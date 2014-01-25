# build static archives for ease of use
noinst_LTLIBRARIES= \
		    libClient.la

AM_CPPFLAGS=  \
	      -I$(abs_top_srcdir)/sources/include    \
	      -I$(abs_top_srcdir)/tests/include      \
	      -DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
	      -DDEFAULT_CONFIG_FILE="\"${confdir}/client.conf\""

libClient_la_SOURCES = \
		       $(top_srcdir)/sources/include/EventLoopCTX.hpp \
		       EventLoopCTX.cpp \
		       \
		       $(top_srcdir)/sources/include/ServerApp.hpp \
		       ServerApp.cpp \
		       \
		       $(top_srcdir)/sources/include/ServerClient.hpp \
		       ServerClient.cpp \
		       \
		       $(top_srcdir)/sources/include/BufferedSocket.hpp \
		       BufferedSocket.cpp \
		       \
		       $(top_srcdir)/sources/include/SocketProxy.hpp \
		       SocketProxy.cpp \
		       \
		       $(top_srcdir)/sources/include/TCPServer.hpp \
		       TCPServer.cpp

MAINTAINERCLEANFILES=Makefile.in
