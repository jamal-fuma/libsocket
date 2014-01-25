bin_PROGRAMS = EchoClient

confdir = $(sysconfdir)/$(PACKAGE)/conf

EchoClient_CPPFLAGS=\
		  -I$(top_srcdir)/sources/include \
		  -I$(top_srcdir)/sources/src	\
		  -I$(top_srcdir)/sources/src/proxy	\
		  -DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
		  -DDEFAULT_CONFIG_FILE="\"${confdir}/client.conf\""

EchoClient_SOURCES = \
		   $(top_srcdir)/sources/include/ServerClient.hpp \
		   EchoClient.hpp \
		   EchoClient.cpp \
		   Main.cpp

EchoClient_LDFLAGS = -Wl,-install_name,@executable_path/../Frameworks

EchoClient_LDADD   = \
		   $(top_builddir)/sources/lib/socket/libSocket.la \
		   $(top_builddir)/sources/lib/client/libClient.la

MAINTAINERCLEANFILES=Makefile.in
