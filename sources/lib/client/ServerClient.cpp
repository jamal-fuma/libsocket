#include <errno.h>
#include "ServerClient.hpp"
#include "BufferedSocket.hpp"
#include "Address.hpp"

ServerClient::ServerClient()
{
}

ServerClient::~ServerClient()
{
}

void ServerClient::connect(const Address & client_addr)
{
    BufferedSocket outgoing;
    outgoing.connect(client_addr);
    established_connection(outgoing);
}

std::string ServerClient::response()
{
    run();
    return drain();
}

void ServerClient::run()
{
    if(-1 != poll_connections())
    {
        exchange_oob(m_ctx);
        exchange_data(m_ctx);
    }
}

int ServerClient::poll_connections()
{
    int rc;

    m_ctx.reset();
    register_connections(m_ctx);

    errno = 0;
    rc = m_ctx.poll();

    return rc;
}

ssize_t ServerClient::write(const std::string & str)
{
    return m_reply.write(str);
}

std::string ServerClient::read()
{
    return m_reply.read();
}

std::string ServerClient::drain()
{
    return m_reply.drain();
}
