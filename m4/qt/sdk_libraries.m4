# FUMA_WITH_QT_LIBRARIES
# ---------------------------------------------------------------
# Add the --with-qt-lib-dir arg
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# QT_LDFLAGS       - makefile variable used in Makefile.am as $(QT_LDFLAGS)             Linker flags
# QT_LIBS          - makefile variable used in Makefile.am as $(QT_LIBS)                Platform libraries
# ---------------------------------------------------------------
#       fuma_ax_qt_library_dir          - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_library_dir
#       fuma_ax_have_qt_library         - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_library
# ---------------------------------------------------------------
# sets following variables for config.h
# ---------------------------------------------------------------
# defines HAVE_QT_LIBS     to 1 if QT was found
# ---------------------------------------------------------------
AC_DEFUN([FUMA_WITH_QT_LIBRARIES],
[dnl
#---------------------------------------------------------------
# FUMA_WITH_QT_LIBRARIES start
#---------------------------------------------------------------
dnl print the user message if they specifed one
    AS_IF([test "x$1" != "x"],[AC_MSG_CHECKING([$1])])

dnl check qt library dir exists
AC_MSG_CHECKING([for presence of qt library directory ${fuma_ax_qt_library_dir}])
AS_IF([test -d "${fuma_ax_qt_library_dir}"],
        [fuma_ax_have_qt_library=yes],
        [fuma_ax_have_qt_library=no])
AC_MSG_RESULT([$fuma_ax_have_qt_library])

dnl check qt binutils dir exists
AC_MSG_CHECKING([for presence of qt binutils directory ${fuma_ax_qt_binutils_dir}])
AS_IF([test -d "${fuma_ax_qt_binutils_dir}"],
        [fuma_ax_have_qt_binutils=yes],
        [fuma_ax_have_qt_binutils=no])
AC_MSG_RESULT([$fuma_ax_have_qt_binutils])

dnl Crap out if we cant find libQT
AS_IF(dnl
        [test "x$fuma_ax_have_qt_library" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT libraries to link against
            -------------------------------------------------
            Fix: pass absolute path to QT library
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-lib-dir=${QT_DIR}/lib
            -------------------------------------------------
            Reason: The --with-qt-lib-dir argument to configure is required, its probably missing.
            It should point to your QT installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl pull in the host libraries for qt
    AS_IF([test "x$darwin"   = "xtrue"],[m4_include([m4/darwin/qt_ldflags.m4])])
    AS_IF([test "x$linux"    = "xtrue"],[m4_include([m4/unix/qt_ldflags.m4])])
    AS_IF([test "x$windows"  = "xtrue"],[m4_include([m4/windows/qt_ldflags.m4])])

dnl Crap out if we cant find QT Host LDFLAGS
    AS_IF(dnl
        [test "x$QT_HOST_LDFLAGS" = "x"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT_HOST_LDFLAGS to use in compilation
            -------------------------------------------------
            Fix: check platform detection macros to ensure correct file in included from m4/qt/sdk_headers.m4
            -------------------------------------------------
            Reason: The QT_HOST_LDFLAGS differ from platform to platform so we need the right ones included.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
        )

dnl Crap out if we cant find QT Host LIBS
    AS_IF(dnl
        [test "x$QT_HOST_LIBS" = "x"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT_HOST_LIBS to use in compilation
            -------------------------------------------------
            Fix: check platform detection macros to ensure correct file in included from m4/qt/sdk_headers.m4
            -------------------------------------------------
            Reason: The QT_HOST_LIBS differ from platform to platform so we need the right ones included.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
        )

dnl setup platform linker flags
AS_IF([test "x$fuma_ax_have_qt_library" = "xyes"],[QT_LDFLAGS="-L${fuma_ax_qt_library_dir} ${QT_HOST_LDFLAGS}"])

dnl setup platform libary archives
AS_IF([test "x$fuma_ax_have_qt_library" = "xyes"],[QT_LIBS="${QT_HOST_LIBS}"])

dnl expose the composite flags to makefiles and configure
AC_SUBST([QT_LDFLAGS])
AC_SUBST([QT_LIBS])

dnl setup linker flags
AS_IF([test "x$fuma_ax_have_qt_library" = "xyes"],[QT_LDFLAGS="${QT_HOST_LDFLAGS}"])

dnl setup libary archives
AS_IF([test "x$fuma_ax_have_qt_library" = "xyes"],[QT_HOST_LIBS="${fuma_ax_qt_library_dir}/QtCore.la"])
AS_IF([test "x$fuma_ax_have_qt_library" = "xyes"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtGui.la"])
AS_IF([test "x$fuma_ax_have_qt_library" = "xyes"],[QT_HOST_LIBS="${QT_LIBS} ${fuma_ax_qt_library_dir}/QtNetwork.la"])

dnl setup config.h define
AC_DEFINE([HAVE_QT_LIBS], [1], [Do we have QT Libraries])

#---------------------------------------------------------------
# FUMA_WITH_QT_LIBRARIES end
#---------------------------------------------------------------
])
