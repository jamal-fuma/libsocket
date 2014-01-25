# FUMA_WITH_SQLITE_LIBRARIES
# ---------------------------------------------------------------
# Add the --with-sqlite-lib-dir arg
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# SQLITE_LDFLAGS       - makefile variable used in Makefile.am as $(SQLITE_LDFLAGS)             Linker flags
# SQLITE_LIBS          - makefile variable used in Makefile.am as $(SQLITE_LIBS)                Platform libraries
# ---------------------------------------------------------------
#       fuma_ax_sqlite_library_dir          - shell variable used in configure scripts and Makefile.am as $fuma_ax_sqlite_library_dir
#       fuma_ax_have_sqlite_library         - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_sqlite_library
# ---------------------------------------------------------------
# sets following variables for config.h
# ---------------------------------------------------------------
# defines HAVE_SQLITE_LIBS     to 1 if SQLITE was found
# ---------------------------------------------------------------

AC_DEFUN([FUMA_AX_CHECK_SQLITE_LIBRARY_DIRECTORY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_LIBRARY_DIRECTORY start
#---------------------------------------------------------------
        dnl check sqlite library dir exists
        AC_MSG_CHECKING([for presence of sqlite library directory ${fuma_ax_sqlite_library_dir}])
        AS_IF([test -d "${fuma_ax_sqlite_library_dir}"],
            [fuma_ax_have_sqlite_library=yes],
            [fuma_ax_have_sqlite_library=no])
        AC_MSG_RESULT([$fuma_ax_have_sqlite_library])

        dnl Crap out if we cant find libSQLITE
        AS_IF([test "x$fuma_ax_have_sqlite_library" = "xno"],
            [AC_ERROR([Error:  We couldnt find the SQLITE libraries to link against
                -------------------------------------------------
                Fix: pass absolute path to SQLITE library
                -------------------------------------------------
                export SQLITE_DIR=/path/to/qt
                ./configure --with-sqlite-lib-dir=${SQLITE_DIR}/lib
                -------------------------------------------------
                Reason: The --with-sqlite-lib-dir argument to configure is required,
                its probably missing.
                It should point to your SQLITE installation.
                -------------------------------------------------])
            ])
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_LIBRARY_DIRECTORY end
#---------------------------------------------------------------
        ])

        AC_DEFUN([FUMA_AX_CHECK_SQLITE_LINKER_FLAGS],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_LINKER_FLAGS start
#---------------------------------------------------------------
                dnl this is for mulithreading and extension loading which hopefull we wont need
                dnl SQLITE_HOST_LDFLAGS="-lpthread -lrt -lltdl"

                dnl setup linker flags
                AC_MSG_CHECKING([for sqlite linker flags])
                AS_IF([test "x$fuma_ax_have_sqlite_library" = "xyes"],
                    [SQLITE_LDFLAGS="${SQLITE_LDFLAGS} -L${fuma_ax_sqlite_library_dir}"])
                AC_MSG_RESULT([$fuma_ax_have_sqlite_library])
                AC_MSG_NOTICE([["$SQLITE_LDFLAGS"]])

                dnl expose the composite flags to makefiles and configure
                AC_SUBST([SQLITE_LDFLAGS])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_LINKER_FLAGS end
#---------------------------------------------------------------
                ])


        AC_DEFUN([FUMA_AX_CHECK_SQLITE_LIBRARY],[dnl
#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_LIBRARY start
#---------------------------------------------------------------
                dnl setup platform libary archives
                AS_IF([test "x$fuma_ax_have_sqlite_library" = "xyes"],
                    [SQLITE_LIBS="${fuma_ax_sqlite_library_dir}/libSqlite.la"])

                dnl expose the composite flags to makefiles and configure
                AC_SUBST([SQLITE_LIBS])

                dnl setup config.h define
                dnl setup config.h define
                AC_DEFINE([HAVE_SQLITE_LIBS], [1], [Do we have SQLITE Libraries])

#---------------------------------------------------------------
# FUMA_AX_CHECK_SQLITE_LIBRARY end
#---------------------------------------------------------------
                ])

        AC_DEFUN([FUMA_WITH_SQLITE_LIBRARIES],[dnl
#---------------------------------------------------------------
# FUMA_WITH_SQLITE_LIBRARIES start
#---------------------------------------------------------------
                dnl print the user message if they specifed one
                AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

                dnl check sqlite library dir exists
                FUMA_AX_CHECK_SQLITE_LIBRARY_DIRECTORY

                dnl setup platform libary archives
                FUMA_AX_CHECK_SQLITE_LIBRARY

                dnl setup host linker flags
                FUMA_AX_CHECK_SQLITE_LINKER_FLAGS

#---------------------------------------------------------------
# FUMA_WITH_SQLITE_LIBRARIES end
#---------------------------------------------------------------
                ])
