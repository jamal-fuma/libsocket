#include "Socket.hpp"
#include "StreamSocket.hpp"
#include "Address.hpp"
#include "Detail.hpp"

StreamSocket::StreamSocket()
    : Socket(socket(AF_INET, SOCK_STREAM, 0))
{
}

StreamSocket::StreamSocket(int sock)
    : Socket(sock)
{
}

StreamSocket::~StreamSocket()
{
    if(get_sockfd() != -1)
        shutdown(SHUT_RDWR);
}

int
StreamSocket::connect(const Address & addr)
{
    return detail::connect(get_sockfd(), addr.get_addr(), addr.get_size());
}

int
StreamSocket::accept(Address & client_addr)
{
    return detail::accept(
        get_sockfd(),
        client_addr.get_addr(),
        client_addr.get_size_ptr()
    );
}

int
StreamSocket::shutdown(int how)
{
    return detail::shutdown(get_sockfd(),how);
}

int
StreamSocket::listen(int connection_backlog)
{
    return detail::listen(get_sockfd(),connection_backlog);
}

int
StreamSocket::getpeername(Address & client_addr)
{
    return detail::getpeername(
        get_sockfd(),
        client_addr.get_addr(),
        client_addr.get_size_ptr()
    );
}
