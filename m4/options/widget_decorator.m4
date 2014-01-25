AC_DEFUN([FUMA_AX_WITH_WIDGET_DECORATOR],[
#---------------------------------------------------------------
# FUMA_AX_WITH_WIDGET_DECORATOR start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl Add the --with-widget-decorator-dir arg
        AC_ARG_WITH([widget-decorator-dir],
            [AS_HELP_STRING([--with-widget-decorator-dir=/path/to/WIDGET_DECORATOR],[path to WIDGET_DECORATOR libraries/headers/binutils])],
            [fuma_ax_widget_decorator_dir="${withval}"],
            [fuma_ax_widget_decorator_dir="${top_srcdir}/../../decorator"])

        dnl Add the --with-widget-decorator-lib-dir arg
        AC_ARG_WITH([widget-decorator-lib-dir], [AS_HELP_STRING([--with-widget-decorator-lib-dir=/path/to/WIDGET_DECORATOR/libs],[path to WIDGET_DECORATOR libraries])],
            [fuma_ax_widget_decorator_library_dir="${withval}"],
            [fuma_ax_widget_decorator_library_dir="${fuma_ax_widget_decorator_dir}/lib"])

        dnl Add the --with-widget-decorator-include-dir arg
        AC_ARG_WITH([widget-decorator-include-dir], [AS_HELP_STRING([--with-widget-decorator-include-dir=/path/to/WIDGET_DECORATOR/Headers],[path to WIDGET_DECORATOR Headers])],
            [fuma_ax_widget_decorator_header_dir="${withval}"],
            [fuma_ax_widget_decorator_header_dir="${fuma_ax_widget_decorator_dir}/include"])
#---------------------------------------------------------------
# FUMA_AX_WITH_WIDGET_DECORATOR end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_WIDGET_DECORATOR_DIR],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_DIR start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])


        dnl check WidgetDecorator dir exists
        AC_MSG_CHECKING([for presence of WidgetDecorator directory ${fuma_ax_widget_decorator_dir}])
        AS_IF([test -d "${fuma_ax_widget_decorator_dir}"],
            [fuma_ax_have_widget_decorator_directory=yes],
            [fuma_ax_have_widget_decorator_directory=no])
        AC_MSG_RESULT([$fuma_ax_have_widget_decorator_directory])
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_DIR end
#---------------------------------------------------------------
                ])

AC_DEFUN([FUMA_AX_CHECK_WIDGET_DECORATOR_HEADER_DIR],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_HEADER_DIR start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl check WidgetDecorator header dir exists
        AC_MSG_CHECKING([for presence of WidgetDecorator header directory ${fuma_ax_widget_decorator_header_dir}])
        AS_IF([test -d "${fuma_ax_widget_decorator_header_dir}"],
            [fuma_ax_have_widget_decorator_header=yes],
            [fuma_ax_have_widget_decorator_header=no])
        AC_MSG_RESULT([$fuma_ax_have_widget_decorator_header])
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_HEADER_DIR end
#---------------------------------------------------------------
                ])

AC_DEFUN([FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARY_DIR],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARY_DIR start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl check WidgetDecorator library dir exists
        AC_MSG_CHECKING([for presence of WidgetDecorator library directory ${fuma_ax_widget_decorator_library_dir}])
        AS_IF([test -d "${fuma_ax_widget_decorator_library_dir}"],
            [fuma_ax_have_widget_decorator_library="yes"],
            [fuma_ax_have_widget_decorator_library="no"])
        AC_MSG_RESULT([$fuma_ax_have_widget_decorator_library])
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARY_DIR end
#---------------------------------------------------------------
                ])

AC_DEFUN([FUMA_AX_SET_WIDGET_DECORATOR_COMPILE_FLAGS],[
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_COMPILE_FLAGS start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl setup compiler flags
        AS_IF([test "x$fuma_ax_have_widget_decorator_header" = "xyes"],
            [WIDGET_DECORATOR_CFLAGS="${WIDGET_DECORATOR_CFLAGS} -pipe"])

        AS_IF([test "x$fuma_ax_have_widget_decorator_header" = "xyes"],
            [WIDGET_DECORATOR_CFLAGS="$WIDGET_DECORATOR_CFLAGS -Wall"])

        AS_IF([test "x$fuma_ax_have_widget_decorator_header" = "xyes"],
                [WIDGET_DECORATOR_CFLAGS="$WIDGET_DECORATOR_CFLAGS -W"])

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([WIDGET_DECORATOR_CFLAGS])
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_COMPILE_FLAGS end
#---------------------------------------------------------------
        ])


AC_DEFUN([FUMA_AX_SET_WIDGET_DECORATOR_PREPROCESSOR_FLAGS],[
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_PREPROCESSOR_FLAGS start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl setup preprocessor flags
        AS_IF([test "x$fuma_ax_have_widget_decorator_header" = "xyes"],
                [WIDGET_DECORATOR_CPPFLAGS="${WIDGET_DECORATOR_CPPFLAGS} -I${fuma_ax_widget_decorator_header_dir}"])

        dnl plumb in the ability to do things differently on shared/static builds
        AS_IF([test "x$fuma_ax_have_widget_decorator_header" = "xyes"],[
                AS_IF([ test "x$enable_shared" = "xyes"],
                    [WIDGET_DECORATOR_CPPFLAGS="${WIDGET_DECORATOR_CPPFLAGS}"])
                ])

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([WIDGET_DECORATOR_CPPFLAGS])
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_PREPROCESSOR_FLAGS end
#---------------------------------------------------------------
        ])


AC_DEFUN([FUMA_AX_SET_WIDGET_DECORATOR_COMPILE],[
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_COMPILE start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl setup compiler flags
        FUMA_AX_SET_WIDGET_DECORATOR_COMPILE_FLAGS([Setting up CFLAGS for WidgetDecorator])

        dnl setup preprocessor flags
        FUMA_AX_SET_WIDGET_DECORATOR_PREPROCESSOR_FLAGS([Setting up CPPFlags for WidgetDecorator])

        dnl expose the composite flags to makefiles and configure
        AC_SUBST([WIDGET_DECORATOR_INCLUDES],["$WIDGET_DECORATOR_CFLAGS $WIDGET_DECORATOR_CPPFLAGS"])

        dnl setup config.h define
        AC_DEFINE([HAVE_WIDGET_DECORATOR_HEADERS], [1], [Define to 1 if we have WIDGET_DECORATOR Headers])
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_COMPILE end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_SET_WIDGET_DECORATOR_LINKER_FLAGS],[
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_LINKER_FLAGS start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

         dnl setup linker flags
        AS_IF([test "x$have_widget_decorator_library" = "xyes"],
                [WIDGET_DECORATOR_LDFLAGS="-L${fuma_ax_widget_decorator_library_dir}"])

        AC_SUBST([WIDGET_DECORATOR_LDFLAGS])
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_LINKER_FLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_SET_WIDGET_DECORATOR_LIBRARIES],[
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_LIBRARIES start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl setup library archives
        AS_IF([test "x$have_widget_decorator_library" = "xyes"],
                [WIDGET_DECORATOR_LIBS="${fuma_ax_widget_decorator_library_dir}/libWidgetDecorator.la"])

        dnl setup makefile defines for libWidgetDecorator
        AC_SUBST([WIDGET_DECORATOR_LIBS])
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_LIBRARIES end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_SET_WIDGET_DECORATOR_LINK],[
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_LINK start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        dnl setup linker flags
        FUMA_AX_SET_WIDGET_DECORATOR_LINKER_FLAGS([Setting up LDFLAGS for WidgetDecorator])

        dnl setup library archives
        FUMA_AX_SET_WIDGET_DECORATOR_LIBRARIES([Setting up LIBS for WidgetDecorator])

        dnl setup config.h define
        AC_DEFINE([HAVE_WIDGET_DECORATOR_LIBS], [1], [Do we have libWidgetDecorator])
#---------------------------------------------------------------
# FUMA_AX_SET_WIDGET_DECORATOR_LINK end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_WIDGET_DECORATOR_HEADERS],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_HEADERS start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        FUMA_AX_CHECK_WIDGET_DECORATOR_HEADER_DIR([checking for the existence of the WidgetDecorator header directory]

        dnl Crap out if we cant find WidgetDecorator Headers
        AS_IF(dnl
            [test "x$fuma_ax_have_widget_decorator_header" = "xno"],[
            AC_ERROR([
                Error:  We couldnt find the WIDGET_DECORATOR headers to include
                -------------------------------------------------
                Fix: pass absolute path to WIDGET_DECORATOR header
                -------------------------------------------------
                export WIDGET_DECORATOR_DIR=${fuma_ax_widget_decorator_header_dir}
                ./configure --with-widget-decorator-include-dir=${WIDGET_DECORATOR_DIR}/include
                -------------------------------------------------
                Reason: The --with-widget-decorator-include-dir argument to configure is required, its probably missing.
                It should point to your WIDGET_DECORATOR installation.
                -------------------------------------------------
                ])dnl
            ]dnl
            )

       dnl setup CFLAGS/CPPFLAGS
      FUMA_AX_SET_WIDGET_DECORATOR_COMPILE([Setting compiler flags for WidgetDecorator library])
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_HEADERS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARIES],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARIES start
#---------------------------------------------------------------
        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARY_DIR([checking for the existence of the WidgetDecorator library directory]

        dnl Crap out if we cant find WidgetDecorator library
        AS_IF(dnl
            [test "x$fuma_ax_have_widget_decorator_library" = "xno"],[
            AC_ERROR([
                Error:  We couldnt find the WIDGET_DECORATOR library to build against
                -------------------------------------------------
                Fix: pass absolute path to WIDGET_DECORATOR library : we got fuma_ax_widget_decorator_library_dir="$fuma_ax_widget_decorator_library_dir"
                -------------------------------------------------
                export WIDGET_DECORATOR_DIR=/path/to/WidgetDecorator
                ./configure --with-widget-decorator-library-dir=${WIDGET_DECORATOR_DIR}/lib
                -------------------------------------------------
                Reason: The --with-widget-decorator-library-dir argument to configure is required, its probably missing.
                It should point to your WidgetDecorator library installation.
                -------------------------------------------------dnl
                ])dnl
            ]dnl
            )

        dnl setup LDFLAGS/LIBS
        FUMA_AX_SET_WIDGET_DECORATOR_LINK([Setting linker flags for WidgetDecorator library])
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARIES end
#---------------------------------------------------------------
    ])


AC_DEFUN([FUMA_AX_WRITE_WIDGET_DECORATOR_BANNER],[
#---------------------------------------------------------------
# FUMA_AX_WRITE_WIDGET_DECORATOR_BANNER start
#---------------------------------------------------------------
        FUMA_AX_WRITELN([Configured with libWidgetDecorator],[$1])
        FUMA_AX_WRITELN([        --with-widget-decorator-dir='${fuma_ax_widget_decorator_dir}'     ],[$1])
        FUMA_AX_WRITELN([        --with-widget-decorator-include-dir='${fuma_ax_widget_decorator_header_dir}'     ],[$1])
        FUMA_AX_WRITELN([        --with-widget-decorator-lib-dir='${fuma_ax_widget_decorator_library_dir}'        ],[$1])

        FUMA_AX_WRITELN([        WIDGET_DECORATOR Libraries:],[$1])
        FUMA_AX_WRITELN([        WIDGET_DECORATOR_CPPFLAGS                =       '${WIDGET_DECORATOR_CPPFLAGS}'],[$1])
        FUMA_AX_WRITELN([        WIDGET_DECORATOR_LDFLAGS                 =       '${WIDGET_DECORATOR_LDFLAGS}'],[$1])
        FUMA_AX_WRITELN([        WIDGET_DECORATOR_LIBS                    =       '${WIDGET_DECORATOR_LIBS}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_WRITE_WIDGET_DECORATOR_BANNER end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_CHECK_WIDGET_DECORATOR],[
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR start
#---------------------------------------------------------------

        dnl print the user message if they specifed one
        AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

        FUMA_AX_CHECK_WIDGET_DECORATOR_DIR([checking for the existence of the WidgetDecorator directory]
        FUMA_AX_CHECK_WIDGET_DECORATOR_HEADERS([checking for the existence of the WidgetDecorator headers]
        FUMA_AX_CHECK_WIDGET_DECORATOR_LIBRARIES([checking for the existence of the WidgetDecorator libraries]

        FUMA_AX_WRITE_WIDGET_DECORATOR_BANNER
#---------------------------------------------------------------
# FUMA_AX_CHECK_WIDGET_DECORATOR end
#---------------------------------------------------------------
    ])
