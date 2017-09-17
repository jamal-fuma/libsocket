#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

#include "EchoClient.hpp"
#include "Address.hpp"
#include "Log.hpp"

int
main(int argc, char *argv[])
{
    if(argc != 2)
    {
        fprintf(stderr, "Usage\n\techo <connect-port> \n");
        return EXIT_FAILURE;
    }

    signal(SIGPIPE, SIG_IGN);

    EchoClient client;
    client.connect(
        Address("84.234.17.171",80)
    );

    ssize_t bytes_out=0, bytes_in=0;

    std::string s;
    bytes_out = client.request(
        "GET / HTTP/1.1\r\n"
        "Host: www.fumasoftware.com\r\n"
        "\r\n"
    );

    for(std::string reply(client.response()); !reply.empty(); reply.assign(client.response()))
    {
        bytes_in += reply.size();
    }

    Log("EchoClient::handle_response()")
        << " sent: " << bytes_out
        << " recv: " << bytes_in
        << " xfer: " << (bytes_in + bytes_out);

    return EXIT_SUCCESS;
}
