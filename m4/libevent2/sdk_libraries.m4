# FUMA_WITH_LIBEVENT2_LIBRARIES
# ---------------------------------------------------------------
# Add the --with-libevent2-lib-dir arg
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# LIBEVENT2_LDFLAGS       - makefile variable used in Makefile.am as $(LIBEVENT2_LDFLAGS)             Linker flags
# LIBEVENT2_LIBS          - makefile variable used in Makefile.am as $(LIBEVENT2_LIBS)                Platform libraries
# ---------------------------------------------------------------
#       fuma_ax_libevent2_library_dir          - shell variable used in configure scripts and Makefile.am as $fuma_ax_libevent2_library_dir
#       fuma_ax_have_libevent2_library         - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_libevent2_library
# ---------------------------------------------------------------
# sets following variables for config.h
# ---------------------------------------------------------------
# defines HAVE_LIBEVENT2_LIBS     to 1 if LIBEVENT2 was found
# ---------------------------------------------------------------

AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_LIBRARY_DIRECTORY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_LIBRARY_DIRECTORY start
#---------------------------------------------------------------
        dnl check libevent2 library dir exists
        AC_MSG_CHECKING([for presence of libevent2 library directory ${fuma_ax_libevent2_library_dir}])
        AS_IF([test -d "${fuma_ax_libevent2_library_dir}"],
            [fuma_ax_have_libevent2_library=yes],
            [fuma_ax_have_libevent2_library=no])
        AC_MSG_RESULT([$fuma_ax_have_libevent2_library])

        dnl Crap out if we cant find libLIBEVENT2
        AS_IF([test "x$fuma_ax_have_libevent2_library" = "xno"],
            [AC_ERROR([Error:  We couldnt find the LIBEVENT2 libraries to link against
                -------------------------------------------------
                Fix: pass absolute path to LIBEVENT2 library
                -------------------------------------------------
                export LIBEVENT2_DIR=/path/to/qt
                ./configure --with-libevent2-lib-dir=${LIBEVENT2_DIR}/lib
                -------------------------------------------------
                Reason: The --with-libevent2-lib-dir argument to configure is required,
                its probably missing.
                It should point to your LIBEVENT2 installation.
                -------------------------------------------------])
            ])
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_LIBRARY_DIRECTORY end
#---------------------------------------------------------------
        ])

        AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_LINKER_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_LINKER_FLAGS start
#---------------------------------------------------------------
                dnl setup linker flags
                AC_MSG_CHECKING([for libevent2 linker flags])
                AS_IF([test "x$fuma_ax_have_libevent2_library" = "xyes"],
                    [LIBEVENT2_LDFLAGS="${LIBEVENT2_LDFLAGS} -L${fuma_ax_libevent2_library_dir}"])
                AC_MSG_RESULT([$fuma_ax_have_libevent2_library])
                AC_MSG_NOTICE([["$LIBEVENT2_LDFLAGS"]])

                dnl expose the composite flags to makefiles and configure
                AC_SUBST([LIBEVENT2_LDFLAGS])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_LINKER_FLAGS end
#---------------------------------------------------------------
                ])


        AC_DEFUN([FUMA_AX_CHECK_LIBEVENT2_LIBRARY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_LIBRARY start
#---------------------------------------------------------------
                dnl setup platform libary archives
                AS_IF([test "x$fuma_ax_have_libevent2_library" = "xyes"],
                    [LIBEVENT2_LIBS="${fuma_ax_libevent2_library_dir}/libevent.a"])

                dnl expose the composite flags to makefiles and configure
                AC_SUBST([LIBEVENT2_LIBS])

                dnl setup config.h define
                dnl setup config.h define
                AC_DEFINE([HAVE_LIBEVENT2_LIBS], [1], [Do we have LIBEVENT2 Libraries])

#---------------------------------------------------------------
# FUMA_AX_CHECK_LIBEVENT2_LIBRARY end
#---------------------------------------------------------------
                ])

        AC_DEFUN([FUMA_WITH_LIBEVENT2_LIBRARIES],[dnl
#---------------------------------------------------------------
# FUMA_WITH_LIBEVENT2_LIBRARIES start
#---------------------------------------------------------------
                dnl print the user message if they specifed one
                AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

                dnl check libevent2 library dir exists
                FUMA_AX_CHECK_LIBEVENT2_LIBRARY_DIRECTORY

                dnl setup platform libary archives
                FUMA_AX_CHECK_LIBEVENT2_LIBRARY

                dnl setup host linker flags
                FUMA_AX_CHECK_LIBEVENT2_LINKER_FLAGS

#---------------------------------------------------------------
# FUMA_WITH_LIBEVENT2_LIBRARIES end
#---------------------------------------------------------------
                ])

