# ---------------------------------------------------------------
# FUMA_WITH_LIBEVENT2_HEADERS
# ---------------------------------------------------------------
# Add the --with-libevent2-include-dir arg
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# LIBEVENT2_INCLUDES           - makefile variable used in Makefile.am as $(LIBEVENT2_INCLUDES)       composite of $(LIBEVENT2_CFLAGS) $(LIBEVENT2_HOST_CFLAGS) $(LIBEVENT2_CPPFLAGS) $(LIBEVENT2_HOST_CPPFLAGS)
# LIBEVENT2_CPPFLAGS           - makefile variable used in Makefile.am as $(LIBEVENT2_CPPFLAGS)       LIBEVENT2 Preprocessor flags
# LIBEVENT2_CFLAGS             - makefile variable used in Makefile.am as $(LIBEVENT2_CFLAGS)         LIBEVENT2 Compilation  flags
# LIBEVENT2_HOST_CPPFLAGS      - makefile variable used in Makefile.am as $(LIBEVENT2_HOST_CPPFLAGS)  LIBEVENT2 Platform specific Preprocessor flags
# LIBEVENT2_HOST_CFLAGS        - makefile variable used in Makefile.am as $(LIBEVENT2_HOST_CFLAGS)    LIBEVENT2 Platform specific Compilation  flags
# ---------------------------------------------------------------
#       fuma_ax_libevent2_header_dir  - shell variable used in configure scripts and Makefile.am as $fuma_ax_libevent2_header_dir
#       fuma_ax_have_libevent2_header - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_libevent2_header
# ---------------------------------------------------------------
# ---------------------------------------------------------------
# sets following variables for config.h
#       defines HAVE_LIBEVENT2_HEADERS to 1 if LIBEVENT2 was found
# ---------------------------------------------------------------

AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_HEADERS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_HEADERS start
#---------------------------------------------------------------
        dnl check libevent2 header dir exists
        AC_MSG_CHECKING([for presence of libevent2 header directory ${fuma_ax_libevent2_header_dir}])
        AS_IF([test -d "${fuma_ax_libevent2_header_dir}"], [fuma_ax_have_libevent2_header=yes], [fuma_ax_have_libevent2_header=no])
        AC_MSG_RESULT([$fuma_ax_have_libevent2_header])

        dnl setup config.h define
        AC_DEFINE([HAVE_LIBEVENT2_H], [1], [Do we have LIBEVENT2 headers])
        AC_DEFINE([HAVE_LIBEVENT2_HEADERS], [1], [Define to 1 if we have LIBEVENT2 Headers])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_HEADERS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_DIRECTORY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_DIRECTORY start
#---------------------------------------------------------------
        dnl check libevent2 dir exists
        AC_MSG_CHECKING([for presence of libevent2 directory ${fuma_ax_libevent2_dir}])
        AS_IF([test -d "${fuma_ax_libevent2_dir}"],
            [fuma_ax_have_libevent2_directory=yes],
            [fuma_ax_have_libevent2_directory=no])
        AC_MSG_RESULT([$fuma_ax_have_libevent2_directory])

        dnl setup config.h define
        AC_DEFINE([HAVE_LIBEVENT2_H], [1], [Do we have LIBEVENT2 headers])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_DIRECTORY end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_COMPILER_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_COMPILER_FLAGS start
#---------------------------------------------------------------

        dnl setup compiler flags
        AC_MSG_CHECKING([for libevent2 compiler flags])
        AS_IF([test "x$fuma_ax_have_libevent2_header" = "xyes"],[LIBEVENT2_CFLAGS="${LIBEVENT2_CFLAGS} ${LIBEVENT2_HOST_CFLAGS}"])
        AC_MSG_NOTICE([["$LIBEVENT2_CFLAGS"]])

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([LIBEVENT2_CFLAGS])
        AC_SUBST([LIBEVENT2_HOST_CFLAGS])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_COMPILER_FLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_PREPROCESSOR_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_PREPROCESSOR_FLAGS start
#---------------------------------------------------------------
        dnl setup preprocessor flags
        AC_MSG_CHECKING([for libevent2 preprocessor flags])
        AS_IF([test "x$fuma_ax_have_libevent2_header" = "xyes"],[LIBEVENT2_CPPFLAGS="-I${fuma_ax_libevent2_header_dir}"])
        AS_IF([test "x$fuma_ax_have_libevent2_header" = "xyes"],[LIBEVENT2_CPPFLAGS="${LIBEVENT2_CPPFLAGS} ${LIBEVENT2_HOST_CPPFLAGS}"])
        AC_MSG_NOTICE([["$LIBEVENT2_CPPFLAGS"]])

        dnl setup config.h define
        AC_SUBST([LIBEVENT2_HOST_CPPFLAGS])
        AC_SUBST([LIBEVENT2_CPPFLAGS])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_PREPROCESSOR_FLAGS end
#---------------------------------------------------------------
        ])


AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_VERSION],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_VERSION start
#---------------------------------------------------------------

        dnl fixme should extract version from lib
        AC_MSG_CHECKING([for libevent2 version number])
        LIBEVENT2_SDK_VERSION="2.0.21"
        LIBEVENT2_SDK_VER_MAJOR="2"
        LIBEVENT2_SDK_VER_MINOR="0"
        LIBEVENT2_SDK_VER_MICRO="21"
        AC_MSG_NOTICE([["$LIBEVENT2_SDK_VERSION"]])

        dnl build LIBEVENT2 release string
        LIBEVENT2_SDK_RELEASE="Built against LIBEVENT2 ${LIBEVENT2_SDK_VER_MAJOR}.${LIBEVENT2_SDK_VER_MINOR}.${LIBEVENT2_SDK_VER_MICRO}"

        dnl expose the version information
        AC_SUBST([LIBEVENT2_SDK_VERSION])
        AC_SUBST([LIBEVENT2_SDK_VER_MICRO])
        AC_SUBST([LIBEVENT2_SDK_VER_MAJOR])
        AC_SUBST([LIBEVENT2_SDK_VER_MINOR])
        AC_SUBST([LIBEVENT2_SDK_RELEASE])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_VERSION end
#---------------------------------------------------------------
    ])


AC_DEFUN([FUMA_WITH_LIBEVENT2_HEADERS],[dnl
#---------------------------------------------------------------
# FUMA_WITH_LIBEVENT2_HEADERS start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl check libevent2 dir exists
        FUMA_AX_CHECK_LIBEVENT2_DIRECTORY
        FUMA_AX_CHECK_LIBEVENT2_HEADERS

        FUMA_AX_CHECK_LIBEVENT2_COMPILER_FLAGS
        FUMA_AX_CHECK_LIBEVENT2_PREPROCESSOR_FLAGS
        FUMA_AX_CHECK_LIBEVENT2_VERSION

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([LIBEVENT2_INCLUDES],["$LIBEVENT2_CFLAGS $LIBEVENT2_HOST_CFLAGS $LIBEVENT2_CPPFLAGS $LIBEVENT2_HOST_CPPFLAGS"])

#---------------------------------------------------------------
# FUMA_WITH_LIBEVENT2_HEADERS end
#---------------------------------------------------------------
])
