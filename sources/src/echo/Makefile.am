bin_PROGRAMS = Echod

confdir = $(sysconfdir)/$(PACKAGE)/conf

Echod_CPPFLAGS=\
		  -I$(top_srcdir)/sources/include \
		  -I$(top_srcdir)/sources/src	\
		  -I$(top_srcdir)/sources/src/proxy	\
		  -DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
		  -DDEFAULT_CONFIG_FILE="\"${confdir}/client.conf\""

Echod_SOURCES = \
		   $(top_srcdir)/sources/include/ServerApp.hpp \
		   EchoApp.hpp \
		   EchoApp.cpp \
		   Main.cpp

Echod_LDFLAGS = -Wl,-install_name,@executable_path/../Frameworks

Echod_LDADD   = \
		   $(top_builddir)/sources/lib/socket/libSocket.la \
		   $(top_builddir)/sources/lib/client/libClient.la

MAINTAINERCLEANFILES=Makefile.in
