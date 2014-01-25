# ---------------------------------------------------------------
# FUMA_WITH_SQLITE_HEADERS
# ---------------------------------------------------------------
# Add the --with-sqlite-include-dir arg
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# SQLITE_INCLUDES           - makefile variable used in Makefile.am as $(SQLITE_INCLUDES)       composite of $(SQLITE_CFLAGS) $(SQLITE_HOST_CFLAGS) $(SQLITE_CPPFLAGS) $(SQLITE_HOST_CPPFLAGS)
# SQLITE_CPPFLAGS           - makefile variable used in Makefile.am as $(SQLITE_CPPFLAGS)       SQLITE Preprocessor flags
# SQLITE_CFLAGS             - makefile variable used in Makefile.am as $(SQLITE_CFLAGS)         SQLITE Compilation  flags
# SQLITE_HOST_CPPFLAGS      - makefile variable used in Makefile.am as $(SQLITE_HOST_CPPFLAGS)  SQLITE Platform specific Preprocessor flags
# SQLITE_HOST_CFLAGS        - makefile variable used in Makefile.am as $(SQLITE_HOST_CFLAGS)    SQLITE Platform specific Compilation  flags
# ---------------------------------------------------------------
#       fuma_ax_sqlite_header_dir  - shell variable used in configure scripts and Makefile.am as $fuma_ax_sqlite_header_dir
#       fuma_ax_have_sqlite_header - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_sqlite_header
# ---------------------------------------------------------------
# ---------------------------------------------------------------
# sets following variables for config.h
#       defines HAVE_SQLITE_HEADERS to 1 if SQLITE was found
# ---------------------------------------------------------------

AC_DEFUN([FUMA_AX_CHECK_SQLITE_HEADERS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_HEADERS start
#---------------------------------------------------------------
        dnl check sqlite header dir exists
        AC_MSG_CHECKING([for presence of sqlite header directory ${fuma_ax_sqlite_header_dir}])
        AS_IF([test -d "${fuma_ax_sqlite_header_dir}"], [fuma_ax_have_sqlite_header=yes], [fuma_ax_have_sqlite_header=no])
        AC_MSG_RESULT([$fuma_ax_have_sqlite_header])

        dnl setup config.h define
        AC_DEFINE([HAVE_SQLITE3_H], [1], [Do we have SQLITE3 headers])
        AC_DEFINE([HAVE_SQLITE_HEADERS], [1], [Define to 1 if we have SQLITE Headers])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_HEADERS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_SQLITE_DIRECTORY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_DIRECTORY start
#---------------------------------------------------------------
        dnl check sqlite dir exists
        AC_MSG_CHECKING([for presence of sqlite directory ${fuma_ax_sqlite_dir}])
        AS_IF([test -d "${fuma_ax_sqlite_dir}"],
            [fuma_ax_have_sqlite_directory=yes],
            [fuma_ax_have_sqlite_directory=no])
        AC_MSG_RESULT([$fuma_ax_have_sqlite_directory])

        dnl setup config.h define
        AC_DEFINE([HAVE_SQLITE3_H], [1], [Do we have SQLITE3 headers])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_DIRECTORY end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_SQLITE_COMPILER_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_COMPILER_FLAGS start
#---------------------------------------------------------------

        dnl setup compiler flags
        AC_MSG_CHECKING([for sqlite compiler flags])
        AS_IF([test "x$fuma_ax_have_sqlite_header" = "xyes"],[SQLITE_CFLAGS="${SQLITE_CFLAGS} ${SQLITE_HOST_CFLAGS}"])
        AC_MSG_NOTICE([["$SQLITE_CFLAGS"]])

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([SQLITE_CFLAGS])
        AC_SUBST([SQLITE_HOST_CFLAGS])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_COMPILER_FLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_SQLITE_PREPROCESSOR_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_PREPROCESSOR_FLAGS start
#---------------------------------------------------------------
        dnl setup preprocessor flags
        AC_MSG_CHECKING([for sqlite preprocessor flags])
        AS_IF([test "x$fuma_ax_have_sqlite_header" = "xyes"],[SQLITE_CPPFLAGS="-I${fuma_ax_sqlite_header_dir}"])
        AS_IF([test "x$fuma_ax_have_sqlite_header" = "xyes"],[SQLITE_HOST_CPPFLAGS="${SQLITE_HOST_CPPFLAGS} -DSQLITE_THREADSAFE=0"])
        AS_IF([test "x$fuma_ax_have_sqlite_header" = "xyes"],[SQLITE_HOST_CPPFLAGS="${SQLITE_HOST_CPPFLAGS} -DSQLITE_OMIT_LOAD_EXTENSION=1"])
        AS_IF([test "x$fuma_ax_have_sqlite_header" = "xyes"],[SQLITE_CPPFLAGS="${SQLITE_CPPFLAGS} ${SQLITE_HOST_CPPFLAGS}"])
        AC_MSG_NOTICE([["$SQLITE_CPPFLAGS"]])

        dnl setup config.h define
        AC_SUBST([SQLITE_HOST_CPPFLAGS])
        AC_SUBST([SQLITE_CPPFLAGS])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_PREPROCESSOR_FLAGS end
#---------------------------------------------------------------
        ])


AC_DEFUN([FUMA_AX_CHECK_SQLITE_VERSION],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_VERSION start
#---------------------------------------------------------------

        dnl fixme should extract version from lib
        AC_MSG_CHECKING([for sqlite version number])
        SQLITE_SDK_VERSION="3.0.0"
        SQLITE_SDK_VER_MAJOR="3"
        SQLITE_SDK_VER_MINOR="0"
        SQLITE_SDK_VER_MICRO="0"
        AC_MSG_NOTICE([["$SQLITE_SDK_VERSION"]])

        dnl build SQLITE release string
        SQLITE_SDK_RELEASE="Built against SQLITE ${SQLITE_SDK_VER_MAJOR}.${SQLITE_SDK_VER_MINOR}.${SQLITE_SDK_VER_MICRO}"

        dnl expose the version information
        AC_SUBST([SQLITE_SDK_VERSION])
        AC_SUBST([SQLITE_SDK_VER_MICRO])
        AC_SUBST([SQLITE_SDK_VER_MAJOR])
        AC_SUBST([SQLITE_SDK_VER_MINOR])
        AC_SUBST([SQLITE_SDK_RELEASE])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_VERSION end
#---------------------------------------------------------------
    ])


AC_DEFUN([FUMA_WITH_SQLITE_HEADERS],[dnl
#---------------------------------------------------------------
# FUMA_WITH_SQLITE_HEADERS start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl check sqlite dir exists
        FUMA_AX_CHECK_SQLITE_DIRECTORY
        FUMA_AX_CHECK_SQLITE_HEADERS

        FUMA_AX_CHECK_SQLITE_COMPILER_FLAGS
        FUMA_AX_CHECK_SQLITE_PREPROCESSOR_FLAGS
        FUMA_AX_CHECK_SQLITE_VERSION

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([SQLITE_INCLUDES],["$SQLITE_CFLAGS $SQLITE_HOST_CFLAGS $SQLITE_CPPFLAGS $SQLITE_HOST_CPPFLAGS"])

#---------------------------------------------------------------
# FUMA_WITH_SQLITE_HEADERS end
#---------------------------------------------------------------
])
