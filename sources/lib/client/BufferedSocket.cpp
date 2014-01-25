#include "BufferedSocket.hpp"
#include "EventLoopCTX.hpp"
#include "Log.hpp"

#include <unistd.h>
#include <sys/socket.h>

#include "Address.hpp"
#include "Detail.hpp"

BufferedSocket::BufferedSocket()
    : m_sock(static_cast<int>(BufferedSocket::kInvalidSocket))
    , m_buffer(FixedBuffer(kBufferSize))
{
}

BufferedSocket::~BufferedSocket()
{
    clear();
    close();
}

BufferedSocket::BufferedSocket(int sock)
    : m_sock(sock)
    , m_buffer(FixedBuffer(kBufferSize))
{
}

BufferedSocket::BufferedSocket(const BufferedSocket & rhs)
    : m_sock(static_cast<int>(BufferedSocket::kInvalidSocket))
    , m_buffer(FixedBuffer(kBufferSize))
{
    copy_assign(rhs);
}

BufferedSocket &
BufferedSocket::operator=(const BufferedSocket & rhs)
{
    copy_assign(rhs);
    return *this;
}

void
BufferedSocket::copy_assign(const BufferedSocket & rhs)
{
    if(this != &rhs)
    {
        Log("BufferedSocket::copy_assign()") << "assign socket with value "
            << rhs.m_sock.get_sockfd()
            << " to socket with value "
            << m_sock.get_sockfd() ;

        m_sock   = rhs.m_sock;
        m_buffer = rhs.m_buffer;
    }
}

void
BufferedSocket::move_assign(BufferedSocket & rhs)
{
    if(this != &rhs)
    {
        Log("BufferedSocket::move_assign()")
            << "forget socket with value " << m_sock.get_sockfd()
            << " acquire socket with value " << rhs.m_sock.get_sockfd() ;

        m_sock   = rhs.m_sock;
        m_buffer = rhs.m_buffer;

        rhs.m_sock = -1;
        rhs.m_buffer.clear();
    }
}

void
BufferedSocket::swap(BufferedSocket & rhs)
{
    if(this != &rhs)
    {
        Log("BufferedSocket::swap()")
            << "swap socket with value " << m_sock.get_sockfd()
            << "for socket with value " << rhs.m_sock.get_sockfd() ;

        std::swap(m_sock,rhs.m_sock);
        std::swap(m_buffer,rhs.m_buffer);
    }
}

int
BufferedSocket::get_sockfd() const
{
    return m_sock.get_sockfd();
}

bool
BufferedSocket::is_valid() const
{
    return (get_sockfd() != kInvalidSocket);
}

int
BufferedSocket::connect(const Address & addr)
{
    StreamSocket sock;

    int rc = sock.connect(addr);
    int err = errno;
    if(kInvalidSocket != rc)
    {
        m_sock.swap(sock);
    }
    else
    {
        Log("BufferedSocket::connect") << "failed " << strerror(err);
    }
    return rc;
}

int
BufferedSocket::get_peername(Address & addr)
{
    return m_sock.getpeername(addr);
}

ssize_t
BufferedSocket::recv()
{
    ssize_t rc = BufferIO::recv(get_sockfd(),m_buffer);
    if (rc == kInvalidSocket || !rc)
        close();
    return rc;
}

ssize_t
BufferedSocket::recv_oob()
{
    ssize_t rc = detail::recv(
            get_sockfd(),
            &m_oob_ch,
            sizeof(m_oob_ch),
            MSG_OOB
            );

    if (rc == kInvalidSocket || !rc)
        close();

    return rc;
}

void BufferedSocket::recv_if_readable(EventLoopCTX & ctx)
{
    EventLoop::recv_if_readable(*this,ctx);
}

void BufferedSocket::send_if_writable(EventLoopCTX & ctx, BufferedSocket & sock_out)
{
    if(is_valid() && EventLoop::is_writeable(*this,ctx))
        sock_out.send(*this);
}

ssize_t
BufferedSocket::send(BufferedSocket & dest)
{
    return BufferIO::send(dest,m_buffer);
}

void BufferedSocket::close_if_empty(BufferedSocket & sock_out)
{
    if(!is_valid() && is_empty())
        sock_out.close();
}

bool
BufferedSocket::is_empty() const
{
    return m_buffer.is_empty();
}

void
BufferedSocket::close()
{
    if(is_valid())
    {
        m_sock.shutdown(SHUT_RDWR);
        m_sock.close();
    }
}

void BufferedSocket::xfer_if_oob(EventLoopCTX & ctx, BufferedSocket & sock_out)
{
    if(EventLoop::recv_oob_if_exceptional(*this,ctx))
        send_oob(sock_out);
}

ssize_t
BufferedSocket::send_oob(BufferedSocket & dest)
{
    ssize_t rc = detail::send(
            dest.get_sockfd(),
            &m_oob_ch,
            sizeof(m_oob_ch),
            MSG_OOB
            );

    if (rc == kInvalidSocket || !rc)
        dest.close();

    return rc;
}

void BufferedSocket::add_if_pollable(EventLoopCTX & ctx, BufferedSocket & sock_out)
{
    add_if_readable(ctx);
    add_if_writable(ctx,sock_out);
    add_if_oob(ctx);
}

void BufferedSocket::add_if_readable(EventLoopCTX & ctx)
{
    // add socket to reader queue if buffer has unused capacity
    if(is_ready_for_reader())
        EventLoop::add_to_readset(*this,ctx);
}

bool
BufferedSocket::is_ready_for_reader() const
{
    // mark socket readable if buffer has unused capacity
    return (is_valid() && m_buffer.is_write_possible());
}

void
BufferedSocket::add_if_writable(EventLoopCTX & ctx,BufferedSocket & sock_out)
{
    // add their socket to writer queue if our buffer contains something to write.
    if(is_valid() && sock_out.is_ready_for_writer())
        EventLoop::add_to_writeset(*this,ctx);
}

bool
BufferedSocket::is_ready_for_writer() const
{
    // mark socket writeable if buffer contains data
    return m_buffer.is_read_pending();
}

void BufferedSocket::add_if_oob(EventLoopCTX & ctx)
{
    // add socket to exeptional queue irrespective of buffer state
    if (is_valid())
        EventLoop::add_to_errorset(*this,ctx);
}

void
BufferedSocket::clear()
{
    m_buffer.clear();
}

std::string
BufferedSocket::drain()
{
    std::string s(read());
    m_buffer.complete_read(s.size());
    return s;
}

std::string
BufferedSocket::read()
{
    return BufferIO::to_string(m_buffer,m_buffer.length());
}

ssize_t
BufferedSocket::write(const std::string & str)
{
    return BufferIO::write(m_buffer,str);
}
