#ifndef FUMA_LIBRARIES_SERVER_APP_HPP
#define FUMA_LIBRARIES_SERVER_APP_HPP

#include "TCPServer.hpp"
#include "EventLoopCTX.hpp"

class ServerApp
{
public:
    ServerApp(const Address & server_addr);
    virtual ~ServerApp();

    void run();
    int poll_connections();

    virtual void accepted_connection(BufferedSocket & incoming) = 0;
    virtual void exchange_oob(EventLoopCTX & ctx) = 0;
    virtual void exchange_data(EventLoopCTX & ctx) = 0;
    virtual void register_connections(EventLoopCTX & ctx) = 0;

private:
    TCPServer m_server;
    EventLoopCTX m_ctx;
};

#endif /* ndef FUMA_LIBRARIES_SERVER_APP_HPP */
