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
        Address("173.194.34.135",80)
    );

    std::string s;
    client.echo("GET / HTTP/1.0\n\n");
    return EXIT_SUCCESS;
}
