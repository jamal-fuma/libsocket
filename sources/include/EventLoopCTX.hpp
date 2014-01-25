#ifndef FUMA_LIBRARIES_CLIENT_EVENT_LOOP_CTX_HPP
#define FUMA_LIBRARIES_CLIENT_EVENT_LOOP_CTX_HPP

#include <sys/time.h>
#include <sys/types.h>
#include <sys/select.h>

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

#endif /*ndef FUMA_LIBRARIES_CLIENT_EVENT_LOOP_CTX_HPP */
