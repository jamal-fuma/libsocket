#include <errno.h>
#include "ProxyApp.hpp"
ProxyApp::ProxyApp(const Address & server_addr, const Address & client_addr)
    : ServerApp(server_addr)
    , m_proxy(client_addr)
{
}

ProxyApp::~ProxyApp()
{
}

void ProxyApp::accepted_connection(BufferedSocket & incoming)
{
    m_proxy.accept(incoming);
}

void ProxyApp::exchange_oob(EventLoopCTX & ctx)
{
    m_proxy.exchange_oob(ctx);
}

void ProxyApp::exchange_data(EventLoopCTX & ctx)
{
    m_proxy.exchange_data(ctx);
}

void ProxyApp::register_connections(EventLoopCTX & ctx)
{
    m_proxy.add_if_pollable(ctx);
}
