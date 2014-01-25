#ifndef FUMA_LIBRARIES_CLIENT_EVENT_LOOP_CTX_HPP
#define FUMA_LIBRARIES_CLIENT_EVENT_LOOP_CTX_HPP

#include <sys/time.h>
#include <sys/types.h>
#include <sys/select.h>
#include <string>
#include <vector>
#include "Detail.hpp"

class EventLoopCTX
{
public:
    EventLoopCTX();
    ~EventLoopCTX();

    void reset();
    void add_to_readset(int sockfd);
    void add_to_writeset(int sockfd);
    void add_to_errorset(int sockfd);
    int poll();

    bool fd_in_readset(int sockfd);
    bool fd_in_writeset(int sockfd);
    bool fd_in_errorset(int sockfd);

private:
    int rc;
    int nfds;
    fd_set rd;
    fd_set wr;
    fd_set er;
};

namespace EventLoop
{
    bool is_readable(int fd, EventLoopCTX & ctx);
    bool is_writeable(int fd, EventLoopCTX & ctx);
    bool is_exceptional(int fd, EventLoopCTX & ctx);
    void add_to_readset(int fd, EventLoopCTX & ctx);
    void add_to_writeset(int fd, EventLoopCTX & ctx);
    void add_to_errorset(int fd, EventLoopCTX & ctx);

    template <typename T>
    bool is_readable(const T & sock, EventLoopCTX & ctx)
    {
        return(sock.get_sockfd() != -1 && EventLoop::is_readable(sock.get_sockfd(),ctx));
    }

    template <typename T>
    bool is_writeable(const T & sock, EventLoopCTX & ctx)
    {
        return(sock.is_valid() && EventLoop::is_writeable(sock.get_sockfd(),ctx));
    }

    template <typename T>
    bool is_exceptional(const T & sock, EventLoopCTX & ctx)
    {
        return(sock.is_valid() && EventLoop::is_exceptional(sock.get_sockfd(),ctx));
    }

    template <typename T>
    void add_to_readset(const T & sock, EventLoopCTX & ctx)
    {
        ctx.add_to_readset(sock.get_sockfd());
    }

    template <typename T>
    void add_to_writeset(const T & sock, EventLoopCTX & ctx)
    {
        ctx.add_to_writeset(sock.get_sockfd());
    }

    template <typename T>
    void add_to_errorset(const T & sock, EventLoopCTX & ctx)
    {
        ctx.add_to_errorset(sock.get_sockfd());
    }

    template <typename T>
    void recv_if_readable(T & sock, EventLoopCTX & ctx)
    {
        if(EventLoop::is_readable(sock,ctx))
            sock.recv();
    }

    template <typename T>
    bool recv_oob_if_exceptional(T & sock, EventLoopCTX & ctx)
    {
        bool oob_ch_available = (sock.is_valid() && EventLoop::is_exceptional(sock,ctx));

        if(oob_ch_available)
            oob_ch_available = ( sock.recv_oob() != T::kInvalidSocket) ;

        return oob_ch_available;
    }
}

namespace BufferIO
{
    template <typename T>
    std::string
    to_string(T & buffer,size_t size)
    {
        size_t length  = buffer.length();
        bool full_read = (!size || size >= length);
        size = (full_read) ? length : size;

        return std::string(buffer.read_head(),size);
    }

    template <typename T>
    ssize_t
    recv(int sockfd, T & buffer)
    {
        ssize_t rc = detail::recv(
                sockfd,
                buffer.write_head(),
                buffer.capacity(),
                0
                );

        if (rc != -1 && rc > 0)
            buffer.complete_write(rc);

        return rc;
    }

    template <typename T>
    ssize_t
    send(int sockfd, T & buffer)
    {
        ssize_t rc = detail::send(
                sockfd,
                buffer.read_head(),
                buffer.length(),
                0
                );

        if (rc != -1 && rc > 0)
            buffer.complete_read(rc);

        return rc;
    }

    template <typename SockT, typename BufT>
    ssize_t
    send(SockT & dest,BufT & buffer)
    {
        ssize_t rc = BufferIO::send(dest.get_sockfd(),buffer);
        if (rc == SockT::kInvalidSocket || !rc)
            dest.close();

        return rc;
    }

    template <typename T>
    ssize_t
    write(T & buffer, const std::string & str)
    {
        size_t size      = str.length();
        size_t capacity  = buffer.capacity();
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

        ::memcpy(buffer.write_head(),&v[0],written);
        buffer.complete_write(written);

        return size - written;
    }
}


#endif /*ndef FUMA_LIBRARIES_CLIENT_EVENT_LOOP_CTX_HPP */
