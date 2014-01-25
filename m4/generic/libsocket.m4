dnl output if we are using the DEBUG feature
AC_DEFUN([FUMA_AX_CHECK_WINSOCK_HEADERS],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WINSOCK_HEADERS start
#---------------------------------------------------------------
        dnl output the features we configured against to screen/file
        AC_MSG_CHECKING([Checking for Windows Socket interface $1])

        dnl windows sockets
        AC_CHECK_HEADERS([windows.h])
        AC_CHECK_HEADERS([winsock2.h])
        AC_CHECK_HEADERS([ws2tcpip.h])

#---------------------------------------------------------------
# FUMA_AX_CHECK_WINSOCK_HEADERS end
#---------------------------------------------------------------
        ])


AC_DEFUN([FUMA_AX_CHECK_POSIX_SOCKETS_HEADERS],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_POSIX_SOCKETS_HEADERS start
#---------------------------------------------------------------
        dnl check for bsd/posix sockets
        AC_MSG_CHECKING([Checking for the BSD Socket interface headers])

        dnl file/socket descriptor manipulation
        AC_CHECK_HEADERS([ev.h])
        AC_CHECK_HEADERS([unistd.h])

        dnl unique identifiers
        AC_CHECK_HEADERS([uuid/uuid.h])

        dnl posix basename/dirname
        AC_CHECK_HEADERS([pwd.h])
        AC_CHECK_HEADERS([libgen.h])

        dnl posix socket header are on multiple platforms
        AC_CHECK_HEADERS([sys/time.h sys/uio.h sys/un.h])
        AC_CHECK_HEADERS([arpa/inet.h netdb.h netinet/in.h netinet/tcp.h])
        AC_CHECK_HEADERS([fcntl.h sys/fcntl.h sys/socket.h sys/select.h sys/ioctl.h sys/mman.h sys/fileio.h]) 

#---------------------------------------------------------------
# FUMA_AX_CHECK_POSIX_SOCKETS_HEADERS end
#---------------------------------------------------------------
    ])


AC_DEFUN([FUMA_AX_CHECK_SOCKET_HEADERS],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_SOCKET_HEADERS start
#---------------------------------------------------------------
        dnl check for winsock
        FUMA_AX_CHECK_WINSOCK_HEADERS

        dnl check for bsd/posix sockets
        FUMA_AX_CHECK_POSIX_SOCKETS_HEADERS

#---------------------------------------------------------------
# FUMA_AX_CHECK_SOCKET_HEADERS end
#---------------------------------------------------------------
])


AC_DEFUN([FUMA_AX_CHECK_SOCKETLIB],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_SOCKETLIB start
#---------------------------------------------------------------

        AC_MSG_CHECKING([Checking for Platform $1 Library])

dnl Checks for headers
        FUMA_AX_CHECK_SOCKET_HEADERS

dnl Checks for types

dnl Checks for libraries.

#---------------------------------------------------------------
# FUMA_AX_CHECK_SOCKETLIB end
#---------------------------------------------------------------
    ])

