#ifndef FUMA_LIBRARIES_PROXY_APP_HPP
#define FUMA_LIBRARIES_PROXY_APP_HPP

#include "ServerApp.hpp"
#include "SocketProxy.hpp"

class ProxyApp
    : public ServerApp
{
public:
    ProxyApp(const Address & server_addr, const Address & client_addr);
    virtual ~ProxyApp();

    virtual void accepted_connection(BufferedSocket & incoming);
    virtual void exchange_oob(EventLoopCTX & ctx);
    virtual void exchange_data(EventLoopCTX & ctx);
    virtual void register_connections(EventLoopCTX & ctx);

private:
    SocketProxy  m_proxy;
};

#endif /* ndef FUMA_LIBRARIES_PROXY_APP_HPP */
