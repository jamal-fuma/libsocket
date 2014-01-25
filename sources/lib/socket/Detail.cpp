#include "Log.hpp"
#include <sys/socket.h>
#include <unistd.h>
#include "Detail.hpp"

ssize_t detail::send(int sockfd, const void *buf, size_t len, int flags)
{
    ssize_t rc;
    do
    {
        errno = 0;
        rc = ::send(sockfd,buf,len,flags);
    }while(rc == -1 && errno == EINTR);

    Log (
            (flags == MSG_OOB) ? "\tdetail::send_oob()" : "\tdetail::send"
        )
        << "sent " << rc
        << " bytes from buffer of length " << len
        << " to socket " << sockfd ;

    if(!rc)
    {
        Log (
                (flags == MSG_OOB) ? "\tdetail::send_oob()" : "\tdetail::send"
            )
            << "attempted write to closed socket " << sockfd ;
    }

    return rc;
}

ssize_t detail::recv(int sockfd, void *buf, size_t len, int flags)
{
    ssize_t rc;
    do
    {
        errno = 0;
        rc = ::recv(sockfd,buf,len,flags);
    }while(rc == -1 && errno == EINTR);

    Log (
            (flags == MSG_OOB) ? "\tdetail::recv_oob()" : "\tdetail::recv"
        ) << "recv " << rc
        << " bytes into buffer of capacity " << len
        << " from socket " << sockfd ;

    if(!rc)
    {
        Log (
                (flags == MSG_OOB) ? "\tdetail::recv_oob()" : "\tdetail::recv"
            )
            << "attempted read from closed socket " << sockfd ;
    }

    return rc;
}

int detail::connect(int sockfd, const struct sockaddr *paddr, size_t len)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::connect(sockfd,paddr,len);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::connect()") << "socket " << sockfd << " connect " << rc;
    return rc;
}

int detail::bind(int sockfd, const struct sockaddr *paddr, size_t len)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::bind(sockfd,paddr,len);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::bind()") << "socket " << sockfd << " bind " << rc;
    return rc;
}


int detail::accept(int sockfd, struct sockaddr *paddr, socklen_t *plen)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::accept(sockfd,paddr,plen);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::accept()") << "socket " << sockfd << " accepted new socket " << rc;
    return rc;
}

int detail::getpeername(int sockfd, struct sockaddr *paddr, socklen_t *plen)
{
    Log("\tdetail::getpeername()") << "getpeername on socket with value " << sockfd;
    int rc;
    do
    {
        errno = 0;
        rc = ::getpeername(sockfd,paddr,plen);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::getpeername()") << "socket " << sockfd << " getpeername " << rc;
    return rc;
}

int detail::listen(int sockfd, int backlog)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::listen(sockfd,backlog);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::listen()") << "socket " << sockfd << " listen " << rc;

    return rc;
}

int detail::shutdown(int sockfd, int how)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::shutdown(sockfd,how);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::shutdown()") << "socket " << sockfd << " shutdown " << rc;

    return rc;
}

int detail::close_socket(int sockfd)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::close(sockfd);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::close_socket()") << "socket " << sockfd << " close " << rc;

    return rc;
}


int detail::select(int nfds, fd_set *rd, fd_set *wr, fd_set *er, struct timeval *tm)
{
    int rc;
    do
    {
        errno = 0;
        rc = ::select(nfds + 1, rd, wr, er, tm);
    }while(rc == -1 && errno == EINTR);

    Log("\tdetail::select()") << "nfds " << nfds+1 << " " << rc;

    return rc;
}
