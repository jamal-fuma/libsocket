#ifndef FUMA_LIBRARIES_SOCKET_DETAIL_HPP
#define FUMA_LIBRARIES_SOCKET_DETAIL_HPP

#include <sys/socket.h>
#include <sys/select.h>

namespace detail
{
    ssize_t send(int sockfd, const void *buf, size_t len, int flags);
    ssize_t recv(int sockfd, void *buf, size_t len, int flags);
    int bind(int sockfd, const struct sockaddr *paddr, size_t len);
    int connect(int sockfd, const struct sockaddr *paddr, size_t len);
    int accept(int sockfd, struct sockaddr *paddr, socklen_t *plen);
    int close_socket(int sockfd);
    int getpeername(int sockfd, struct sockaddr *paddr, socklen_t *plen);
    int listen(int sockfd, int backlog);
    int shutdown(int sockfd, int how);
    int select(int nfds, fd_set *rd, fd_set *wr, fd_set *er, struct timeval *tm);

};

#endif /*ndef FUMA_LIBRARIES_SOCKET_DETAIL_HPP */
