#ifndef FUMA_LIBRARIES_SERVER_CLIENT_HPP
#define FUMA_LIBRARIES_SERVER_CLIENT_HPP

class Address;
#include "BufferedSocket.hpp"
#include "EventLoopCTX.hpp"

class ServerClient
{
public:
    ServerClient();
    virtual ~ServerClient();

    void connect(const Address & client_addr);
    void run();
    int poll_connections();
    std::string response();

    virtual void established_connection(BufferedSocket & incoming) = 0;
    virtual void exchange_oob(EventLoopCTX & ctx) = 0;
    virtual void exchange_data(EventLoopCTX & ctx) = 0;
    virtual void register_connections(EventLoopCTX & ctx) = 0;

    ssize_t write(const std::string & str);
    std::string read();
    std::string drain();

private:
    BufferedSocket m_reply;
    EventLoopCTX m_ctx;
};

#endif /* ndef FUMA_LIBRARIES_SERVER_CLIENT_HPP */
