#ifndef FUMA_LIBRARIES_ECHO_APP_HPP
#define FUMA_LIBRARIES_ECHO_APP_HPP

#include "ServerApp.hpp"
#include "BufferedSocket.hpp"

class EchoApp
    : public ServerApp
{
public:
    EchoApp(const Address & server_addr);
    virtual ~EchoApp();

    virtual void accepted_connection(BufferedSocket & incoming);
    virtual void exchange_oob(EventLoopCTX & ctx);
    virtual void exchange_data(EventLoopCTX & ctx);
    virtual void register_connections(EventLoopCTX & ctx);

    BufferedSocket m_client;
};

#endif /* ndef FUMA_LIBRARIES_ECHO_APP_HPP */
