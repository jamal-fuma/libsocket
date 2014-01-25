#include "Address.hpp"
#include "TCPServer.hpp"
#include "BufferedSocket.hpp"
#include "EventLoopCTX.hpp"
#include "Log.hpp"

TCPServer::TCPServer(const Address & addr)
: StreamSocket()
{
    set_reusable_address();
    if(bind(addr))
        throw "Unable to bind port";

    listen(10);
}

TCPServer::~TCPServer()
{
}


bool
TCPServer::accept(BufferedSocket & sock)
{
    Address addr;
    BufferedSocket client(StreamSocket::accept(addr));

    bool rc(client.is_valid());
    if(rc)
    {
        sock.move_assign(client);
    }

    return rc;
}

void
TCPServer::add_readable_sockets(EventLoopCTX & ctx)
{
    ctx.add_to_readset(get_sockfd());
}

bool
TCPServer::accept_connecting_socket(EventLoopCTX & ctx, BufferedSocket & connection)
{
    return (ctx.fd_in_readset(get_sockfd()) && accept(connection));
}
