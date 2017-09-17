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

ssize_t EchoClient::request(const std::string & str)
{
    ssize_t written = 0;
    ssize_t rc;

    ssize_t begin(0);
    ssize_t remaining(str.size());

    do
    {
        rc = m_server.write(str.substr(begin+written));
        if(rc > 0)
        {
            written += rc;
        }
        run();
    }while((remaining - written) > 0 && rc > 0);

    return written;
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
