#ifndef FUMA_LIBRARIES_SOCKET_DATAGRAM_SOCKET_HPP
#define FUMA_LIBRARIES_SOCKET_DATAGRAM_SOCKET_HPP

#include "Socket.hpp"
class DatagramSocket
    : public Socket
{
public:
    DatagramSocket();
    virtual ~DatagramSocket();
};

#endif /*ndef FUMA_LIBRARIES_SOCKET_DATAGRAM_SOCKET_HPP */
