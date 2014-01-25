#include <errno.h>
#include "ServerApp.hpp"
#include "BufferedSocket.hpp"
ServerApp::ServerApp(const Address & server_addr)
    : m_server(server_addr)
{
}

ServerApp::~ServerApp()
{
}

void ServerApp::run()
{
    BufferedSocket incoming;
    while(-1 != poll_connections())
    {
        if(m_server.accept_connecting_socket(m_ctx,incoming))
        {
            accepted_connection(incoming);
        }

        exchange_oob(m_ctx);

        exchange_data(m_ctx);
    }
}

int ServerApp::poll_connections()
{
    int rc;

    m_ctx.reset();
    m_server.add_readable_sockets(m_ctx);
    register_connections(m_ctx);

    errno = 0;
    rc = m_ctx.poll();

    return rc;
}
