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

BufferedSocket::BufferedSocket(int sock)
    : m_sock(sock)
    , m_buffer(FixedBuffer(kBufferSize))
{
}

BufferedSocket::~BufferedSocket()
{
    clear();
    close();
}

BufferedSocket::BufferedSocket(const BufferedSocket & rhs)
    : m_sock(static_cast<int>(BufferedSocket::kInvalidSocket))
    , m_buffer(FixedBuffer(kBufferSize))
{
    copy_assign(rhs);
}

BufferedSocket & BufferedSocket::operator=(const BufferedSocket & rhs)
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

bool
BufferedSocket::is_empty() const
{
    return m_buffer.is_empty();
}

bool
BufferedSocket::is_ready_for_reader() const
{
    return (is_valid() && m_buffer.is_write_possible());
}

bool
BufferedSocket::is_ready_for_writer() const
{
    return m_buffer.is_read_pending();
}

ssize_t
BufferedSocket::recv()
{
    ssize_t rc = detail::recv(
        get_sockfd(),
        m_buffer.write_head(),
        m_buffer.capacity(),
        0
    );
    if (rc == kInvalidSocket || !rc)
        close();
    else
        m_buffer.complete_write(rc);

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

std::string
BufferedSocket::read()
{
    return std::string(m_buffer.read_head(),m_buffer.length());
}

ssize_t
BufferedSocket::write(const std::string & str)
{
    size_t size      = str.length();
    size_t capacity  = m_buffer.capacity();
    bool fragmented_write = (size > capacity);

    std::string::const_iterator end(
        (fragmented_write) ? str.begin() : str.end()
    );

    if(fragmented_write)
    {
        std::advance(end,capacity);
    }

    std::vector<char> v(str.begin(),end);
    size_t written(v.size());

    ::memcpy(m_buffer.read_head(),&v[0],written);
    m_buffer.complete_write(written);

    return size - written;
}


ssize_t
BufferedSocket::send(BufferedSocket & dest)
{
    ssize_t rc = detail::send(
        dest.get_sockfd(),
        m_buffer.read_head(),
        m_buffer.length(),
        0
    );
    if (rc == kInvalidSocket || !rc)
        dest.close();
    else
        m_buffer.complete_read(rc);

    return rc;
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

int
BufferedSocket::connect(const Address & addr)
{
    StreamSocket sock;

    int rc = sock.connect(addr);
    if(kInvalidSocket != rc)
    {
        m_sock.swap(sock);
    }
    return rc;
}

int
BufferedSocket::get_peername(Address & addr)
{
    return m_sock.getpeername(addr);
}

void
BufferedSocket::clear()
{
    m_buffer.clear();
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

void BufferedSocket::recv_if_readable(EventLoopCTX & ctx)
{
    if(is_valid() && ctx.fd_in_readset(get_sockfd()))
        recv();
}

void BufferedSocket::send_if_writable(EventLoopCTX & ctx, BufferedSocket & sock_out)
{
    if(is_valid() && ctx.fd_in_writeset(get_sockfd()))
        sock_out.send(*this);
}

void BufferedSocket::close_if_empty(BufferedSocket & sock_out)
{
    if(!is_valid() && is_empty())
        sock_out.close();
}

void BufferedSocket::xfer_if_oob(EventLoopCTX & ctx, BufferedSocket & sock_out)
{
    if(is_valid() && ctx.fd_in_errorset(get_sockfd()))
        if ( recv_oob() != BufferedSocket::kInvalidSocket)
            send_oob(sock_out);
}

void BufferedSocket::add_if_readable(EventLoopCTX & ctx)
{
    if(is_ready_for_reader())
        ctx.add_to_readset(get_sockfd());
}

void BufferedSocket::add_if_writable(EventLoopCTX & ctx,BufferedSocket & sock_out)
{
    if(is_valid() && sock_out.is_ready_for_writer())
        ctx.add_to_writeset(get_sockfd());
}

void BufferedSocket::add_if_oob(EventLoopCTX & ctx)
{
    if (is_valid())
        ctx.add_to_errorset(get_sockfd());
}
void BufferedSocket::add_if_pollable(EventLoopCTX & ctx, BufferedSocket & sock_out)
{
    add_if_readable(ctx);
    add_if_writable(ctx,sock_out);
    add_if_oob(ctx);
}
