#ifndef FUMA_LIBRARIES_ECHO_CLIENT_HPP
#define FUMA_LIBRARIES_ECHO_CLIENT_HPP

#include "ServerClient.hpp"
#include "BufferedSocket.hpp"

class EchoClient
    : public ServerClient
{
public:
    EchoClient();
    virtual ~EchoClient();

    ssize_t request(const std::string & str);

    virtual void established_connection(BufferedSocket & outgoing);
    virtual void exchange_oob(EventLoopCTX & ctx);
    virtual void exchange_data(EventLoopCTX & ctx);
    virtual void register_connections(EventLoopCTX & ctx);

    BufferedSocket m_server;
};

#endif /* ndef FUMA_LIBRARIES_ECHO_CLIENT_HPP */
