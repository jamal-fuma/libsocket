bin_PROGRAMS = SocketFwd

confdir = $(sysconfdir)/$(PACKAGE)/conf

SocketFwd_CPPFLAGS=\
		  -I$(top_srcdir)/sources/include \
		  -I$(top_srcdir)/sources/src	\
		  -DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
		  -DDEFAULT_CONFIG_FILE="\"${confdir}/client.conf\""

SocketFwd_SOURCES = \
		   ServerApp.hpp \
		   ServerApp.cpp \
		   ProxyApp.hpp \
		   ProxyApp.cpp \
		   Main.cpp

SocketFwd_LDFLAGS = -Wl,-install_name,@executable_path/../Frameworks

SocketFwd_LDADD   = \
		   $(top_builddir)/sources/lib/socket/libSocket.la \
		   $(top_builddir)/sources/lib/client/libClient.la

MAINTAINERCLEANFILES=Makefile.in
