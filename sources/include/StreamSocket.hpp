#ifndef FUMA_LIBRARIES_SOCKET_STREAM_SOCKET_HPP
#define FUMA_LIBRARIES_SOCKET_STREAM_SOCKET_HPP

#include "Socket.hpp"

class Address;

class StreamSocket
    : public Socket
{
public:
    StreamSocket();
    virtual ~StreamSocket();

    StreamSocket(int sock);

    int connect(const Address & addr);
    int accept(Address & addr);
    int shutdown(int how);
    int listen(int connection_backlog);
    int getpeername(Address & client_addr);
};

#endif /*ndef FUMA_LIBRARIES_SOCKET_STREAM_SOCKET_HPP */
