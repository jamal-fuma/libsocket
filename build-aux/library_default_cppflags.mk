DEFAULT_PREPROCESSOR_FLAGS=  \
        -I$(top_srcdir)/sources/include    \
        -I$(top_srcdir)/sources/src	   \
	-DPACKAGE_VERSION="\"${PACKAGE_VERSION}\"" \
	-DDEFAULT_CONFIG_FILE="\"${confdir}/client.conf\""
