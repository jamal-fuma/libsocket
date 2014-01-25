#include "BufferedSocket.hpp"
#include "Address.hpp"

class EventLoopCTX;

class SocketProxy
{
    public:
        SocketProxy(const Address & client_addr);
        ~SocketProxy();

        void accept(BufferedSocket & incoming);
        void add_if_pollable(EventLoopCTX & ctx);
        void exchange_oob(EventLoopCTX & ctx);
        void recv_data(EventLoopCTX & ctx);
        void send_data(EventLoopCTX & ctx);
        void exchange_data(EventLoopCTX & ctx);

    private:
        BufferedSocket m_incoming;
        BufferedSocket m_outgoing;
        Address        m_client_addr;
};
