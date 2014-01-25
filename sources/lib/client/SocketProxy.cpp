#include "SocketProxy.hpp"
#include "EventLoopCTX.hpp"
#include "Log.hpp"

SocketProxy::SocketProxy(const Address & client_addr)
: m_client_addr(client_addr)
{
        Log("SocketProxy()") << "forwarding destination is " << client_addr;
}

SocketProxy::~SocketProxy()
{
}

void SocketProxy::accept(BufferedSocket & incoming)
{
    m_incoming.move_assign(incoming);
    if(m_incoming.is_valid())
    {
        Address remote_peer;
        m_incoming.get_peername(remote_peer);

        Log("SocketProxy::accept()") << "got connect from " << remote_peer;

        m_outgoing.connect(m_client_addr);
        if(!m_outgoing.is_valid())
        {
            Log("SocketProxy::accept()")
                << " forwarding "
                << remote_peer
                << " to "
                << m_client_addr
                << " aborted as connection to "
                << m_client_addr
                << " failed"
                ;

            m_incoming.close();

        }
        else
        {
            Log("SocketProxy::accept()")
                << " forwarding "
                << remote_peer
                << " to "
                << m_client_addr
                << " started"
                ;
        }
    }
}

void SocketProxy::add_if_pollable(EventLoopCTX & ctx)
{
    m_incoming.add_if_pollable(ctx,m_outgoing);
    m_outgoing.add_if_pollable(ctx,m_incoming);
}

void SocketProxy::exchange_oob(EventLoopCTX & ctx)
{
    m_incoming.xfer_if_oob(ctx,m_outgoing);
    m_outgoing.xfer_if_oob(ctx,m_incoming);
}

void SocketProxy::recv_data(EventLoopCTX & ctx)
{
    m_incoming.recv_if_readable(ctx);
    m_outgoing.recv_if_readable(ctx);
}

void SocketProxy::send_data(EventLoopCTX & ctx)
{
    m_incoming.send_if_writable(ctx,m_outgoing);
    m_outgoing.send_if_writable(ctx,m_incoming);

    m_incoming.close_if_empty(m_outgoing);
    m_outgoing.close_if_empty(m_incoming);
}

void SocketProxy::exchange_data(EventLoopCTX & ctx)
{
    recv_data(ctx);
    send_data(ctx);
}
