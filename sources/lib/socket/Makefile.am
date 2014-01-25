# build static archives for ease of use
noinst_LTLIBRARIES= \
		    libSocket.la

AM_CPPFLAGS=  \
	      -I$(top_srcdir)/sources/include    \
	      -I$(top_srcdir)/tests/include      \
	      -DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
	      -DDEFAULT_CONFIG_FILE="\"${confdir}/client.conf\""

libSocket_la_SOURCES = \
		       $(top_srcdir)/sources/include/FixedBuffer.hpp \
		       FixedBuffer.cpp \
		       \
		       $(top_srcdir)/sources/include/Socket.hpp \
		       Socket.cpp \
		       \
		       $(top_srcdir)/sources/include/StreamSocket.hpp \
		       StreamSocket.cpp \
		       \
		       $(top_srcdir)/sources/include/DatagramSocket.hpp \
		       DatagramSocket.cpp \
		       \
		       $(top_srcdir)/sources/include/Address.hpp \
		       Address.cpp \
		       \
		       $(top_srcdir)/sources/include/Detail.hpp \
		       Detail.cpp

MAINTAINERCLEANFILES=Makefile.in
