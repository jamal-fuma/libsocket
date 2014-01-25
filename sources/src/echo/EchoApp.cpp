#include <errno.h>
#include "EchoApp.hpp"
#include "Log.hpp"

EchoApp::EchoApp(const Address & server_addr)
    : ServerApp(server_addr)
{
}

EchoApp::~EchoApp()
{
}

void EchoApp::accepted_connection(BufferedSocket & incoming)
{
    m_client.move_assign(incoming);
}

void EchoApp::exchange_oob(EventLoopCTX & ctx)
{
    m_client.xfer_if_oob(ctx,m_client);
}

void EchoApp::exchange_data(EventLoopCTX & ctx)
{
    if(EventLoop::is_writeable(m_client,ctx))
    {
        std::string buf(m_client.drain());
        m_client.write(">> : ");
        m_client.write(buf);
        m_client.send(m_client);
    }

    if(EventLoop::is_readable(m_client,ctx))
    {
        ssize_t rc = m_client.recv();
        Log("EchoApp")
            << "<< : " << m_client.get_sockfd() << std::string(": ") << m_client.read();
    }
}

void EchoApp::register_connections(EventLoopCTX & ctx)
{
    m_client.add_if_readable(ctx);
    m_client.add_if_oob(ctx);
    if(!m_client.is_empty())
        m_client.add_if_writable(ctx,m_client);
}
