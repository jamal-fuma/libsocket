#include <stdlib.h>
#include <stdio.h>
#include <signal.h>

#include "EchoApp.hpp"
#include "Address.hpp"

int
main(int argc, char *argv[])
{
    if(argc != 2)
    {
        fprintf(stderr, "Usage\n\techo <listen-port> \n");
        return EXIT_FAILURE;
    }

    signal(SIGPIPE, SIG_IGN);

    EchoApp app(
        Address(atoi(argv[1]))
    );
    app.run();

    return EXIT_SUCCESS;
}
