#include "StreamSocket.hpp"

class EventLoopCTX;
class Address;
class BufferedSocket;

class TCPServer
    : public StreamSocket
{
public:
    TCPServer(const Address & addr);
    virtual ~TCPServer();

    bool accept(BufferedSocket & sock);
    void add_readable_sockets(EventLoopCTX & ctx);
    bool accept_connecting_socket(EventLoopCTX & ctx, BufferedSocket & connection);
};
