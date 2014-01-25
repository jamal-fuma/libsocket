#include <errno.h>
#include "EchoClient.hpp"
#include "Log.hpp"
#include <stdexcept>

EchoClient::EchoClient()
    : ServerClient()
{
}

EchoClient::~EchoClient()
{
}

ssize_t EchoClient::echo(const std::string & str)
{
    ssize_t rc = m_server.write(str);
    run();

    std::string s;
    while(1)
    {
        s = response();
        std::cout << s << std::endl;
        if(s.empty())
            break;
    }

    return rc;
}

void EchoClient::established_connection(BufferedSocket & outgoing)
{
    if(!outgoing.is_valid())
        throw std::runtime_error("Connection failed to establish");

    m_server.move_assign(outgoing);
}

void EchoClient::exchange_oob(EventLoopCTX & ctx)
{
    m_server.xfer_if_oob(ctx,m_server);
}

void EchoClient::exchange_data(EventLoopCTX & ctx)
{
    m_server.send_if_writable(ctx,m_server);

    if(EventLoop::is_readable(m_server,ctx))
    {
        ssize_t rc = m_server.recv();
        write(m_server.drain());
    }
}

void EchoClient::register_connections(EventLoopCTX & ctx)
{
    m_server.add_if_readable(ctx);
    m_server.add_if_oob(ctx);
    m_server.add_if_writable(ctx,m_server);
}
