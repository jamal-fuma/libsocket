#include <algorithm>
#include "EventLoopCTX.hpp"
#include "Detail.hpp"
#include "Log.hpp"
EventLoopCTX::EventLoopCTX()
{
    reset();
}

EventLoopCTX::~EventLoopCTX()
{
}

void EventLoopCTX::reset()
{
    nfds = 0;
    FD_ZERO(&rd);
    FD_ZERO(&wr);
    FD_ZERO(&er);
}

void EventLoopCTX::add_to_readset(int sockfd)
{
    FD_SET(sockfd, &rd);
    nfds = std::max(nfds, sockfd);
}

void EventLoopCTX::add_to_writeset(int sockfd)
{
    FD_SET(sockfd, &wr);
    nfds = std::max(nfds, sockfd);
}

void EventLoopCTX::add_to_errorset(int sockfd)
{
    FD_SET(sockfd, &er);
    nfds = std::max(nfds, sockfd);
}

int EventLoopCTX::poll()
{
    if(nfds == 0)
        return 0;

    return detail::select(nfds + 1, &rd, &wr, &er, NULL);
}

bool EventLoopCTX::fd_in_readset(int sockfd)
{
    return FD_ISSET(sockfd, &rd);
}

bool EventLoopCTX::fd_in_writeset(int sockfd)
{
    return FD_ISSET(sockfd, &wr);
}

bool EventLoopCTX::fd_in_errorset(int sockfd)
{
    return FD_ISSET(sockfd, &er);
}

bool EventLoop::is_readable(int fd, EventLoopCTX & ctx)
{
    bool rc = ctx.fd_in_readset(fd);
    if(rc)
        Log("EventLoop::is_readable()")
                << "socket with value " << fd << " is ready for Read I/O" ;

    return rc;
}

bool EventLoop::is_writeable(int fd, EventLoopCTX & ctx)
{
    bool rc = ctx.fd_in_writeset(fd);
    if(rc)
        Log("EventLoop::is_writable()")
                << "socket with value " << fd << " is ready for Write I/O" ;
    return rc;
}

bool EventLoop::is_exceptional(int fd, EventLoopCTX & ctx)
{
    bool rc = ctx.fd_in_errorset(fd);
    if(rc)
        Log("EventLoop::is_exceptional()")
                << "socket with value " << fd << " is ready for OOB I/O" ;
    return rc;
}

void EventLoop::add_to_readset(int fd, EventLoopCTX & ctx)
{
    ctx.add_to_readset(fd);
}

void EventLoop::add_to_writeset(int fd, EventLoopCTX & ctx)
{
    ctx.add_to_writeset(fd);
}

void EventLoop::add_to_errorset(int fd, EventLoopCTX & ctx)
{
    ctx.add_to_errorset(fd);
}
