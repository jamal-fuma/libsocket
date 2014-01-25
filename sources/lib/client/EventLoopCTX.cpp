#include <algorithm>
#include "EventLoopCTX.hpp"
#include "Detail.hpp"

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
