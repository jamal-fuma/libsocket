#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

#include "ProxyApp.hpp"

int
main(int argc, char *argv[])
{
    if(argc != 4)
    {
        fprintf(stderr, "Usage\n\tfwd <listen-port> "
                "<forward-to-port> <forward-to-ip-address>\n");
        return EXIT_FAILURE;
    }

    signal(SIGPIPE, SIG_IGN);

    ProxyApp app(
        Address(atoi(argv[1])),
        Address(argv[3],atoi(argv[2]))
    );
    app.run();

    return EXIT_SUCCESS;
}
