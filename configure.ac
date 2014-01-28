# Process this file with autoconf to produce a configure script.
AC_PREREQ([2.61])
AC_INIT([fuma-socket-library],[0.0.3],[jamal.natour@fumasoftware.com])

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

# location of additional build machinary
AC_CONFIG_HEADERS([config.h])
AC_SUBST([ACLOCAL_AMFLAGS], ["-I $ac_macro_dir \${ACLOCAL_FLAGS} --install"])
AC_CONFIG_SRCDIR([sources/include/Log.hpp])
AM_INIT_AUTOMAKE([1.10 no-define foreign tar-pax])

m4_include([m4/generic/fuma_ax_write.m4])
m4_include([m4/generic/fuma_ax_compile.m4])
m4_include([m4/generic/fuma_ax_distribution.m4])

m4_include([m4/generic/fuma_ax_arg_enable.m4])
m4_include([m4/generic/fuma_ax_cppflags_if_enabled.m4])

# Checks for programs.
m4_include([m4/generic/compilation_toolchain.m4])

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h errno.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_INLINE
AC_DISABLE_SHARED
AC_ENABLE_STATIC

# common funcs across windows and unix
AC_CHECK_FUNCS([getenv setenv])

AC_CONFIG_FILES([Makefile
                 sources/Makefile
                 sources/include/Makefile
                 sources/lib/Makefile
                 sources/lib/socket/Makefile
                 sources/lib/client/Makefile
                 sources/src/Makefile
                 sources/src/proxy/Makefile
                 sources/src/echo/Makefile
                 sources/src/client/Makefile
                 ])

# I like maintainer mode
AM_MAINTAINER_MODE

# set build hosts appropriately
m4_include([m4/generic/fuma_ax_cannonical_host.m4])
m4_include([m4/generic/fuma_ax_platform.m4])

# Checks for compilers and related programs,  setting build host appropriately
m4_include([m4/options/host.m4])

m4_include([m4/generic/fuma_ax_debug.m4])
m4_include([m4/generic/fuma_ax_verbose_build.m4])

# add the --debug option
m4_include([m4/options/debug.m4])

# add the --verbose option
m4_include([m4/options/verbose.m4])

# add the --tests option
m4_include([m4/options/tests.m4])
m4_include([m4/generic/fuma_ax_test_suite.m4])

# cross platform time functions
m4_include([m4/generic/time.m4])

# detect correct names for intger types on platform
m4_include([m4/generic/integer_types.m4])
m4_include([m4/generic/libc.m4])

AC_OUTPUT

AC_DEFUN([FUMA_SYSTEM_BANNER],[
#---------------------------------------------------------------
# FUMA_SYSTEM_BANNER start
#---------------------------------------------------------------
#  Compile banner
FUMA_AX_WRITELN([${PACKAGE_NAME}-${PACKAGE_VERSION}],[version.txt])
FUMA_AX_WRITELN([${PACKAGE_NAME} Version ${PACKAGE_VERSION}],[$1])
FUMA_AX_BUILD([$1])
FUMA_AX_DISTRIBUTION([$1])

# FUMA_SYSTEM_BANNER end
#---------------------------------------------------------------
])

FUMA_SYSTEM_BANNER([release.txt])
