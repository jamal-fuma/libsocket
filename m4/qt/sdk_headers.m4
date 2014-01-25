# ---------------------------------------------------------------
# FUMA_WITH_QT_HEADERS
# ---------------------------------------------------------------
# Add the --with-qt-include-dir arg
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# QT_INCLUDES           - makefile variable used in Makefile.am as $(QT_INCLUDES)       composite of $(QT_CFLAGS) $(QT_HOST_CFLAGS) $(QT_CPPFLAGS) $(QT_HOST_CPPFLAGS)
# QT_CPPFLAGS           - makefile variable used in Makefile.am as $(QT_CPPFLAGS)       QT Preprocessor flags
# QT_CFLAGS             - makefile variable used in Makefile.am as $(QT_CFLAGS)         QT Compilation  flags
# QT_HOST_CPPFLAGS      - makefile variable used in Makefile.am as $(QT_HOST_CPPFLAGS)  QT Platform specific Preprocessor flags
# QT_HOST_CFLAGS        - makefile variable used in Makefile.am as $(QT_HOST_CFLAGS)    QT Platform specific Compilation  flags
# ---------------------------------------------------------------
#       fuma_ax_qt_header_dir  - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_header_dir
#       fuma_ax_have_qt_header - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_header
# ---------------------------------------------------------------
#       fuma_ax_qt_specs_dir  - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_specs_dir
#       fuma_ax_have_qt_specs - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_specs
# ---------------------------------------------------------------
# sets following variables for config.h
#       defines HAVE_QT_HEADERS to 1 if QT was found
#       defines HAVE_QT_SPECS   to 1 if QT Specs include path was found
# ---------------------------------------------------------------
AC_DEFUN([FUMA_WITH_QT_HEADERS],
[dnl
#---------------------------------------------------------------
# FUMA_WITH_QT_HEADERS start
#---------------------------------------------------------------
dnl print the user message if they specifed one
    AS_IF([test "x$1" != "x"],[AC_MSG_NOTICE([$1])])

dnl check qt dir exists
AC_MSG_CHECKING([for presence of qt directory ${fuma_ax_qt_dir}])
AS_IF([test -d "${fuma_ax_qt_dir}"],
        [fuma_ax_have_qt_directory=yes],
        [fuma_ax_have_qt_directory=no])
AC_MSG_RESULT([$fuma_ax_have_qt_directory])

dnl check qt header dir exists
AC_MSG_CHECKING([for presence of qt header directory ${fuma_ax_qt_header_dir}])
AS_IF([test -d "${fuma_ax_qt_header_dir}"],
        [fuma_ax_have_qt_header=yes],
        [fuma_ax_have_qt_header=no])
AC_MSG_RESULT([$fuma_ax_have_qt_header])

dnl check qt specs dir exists
AC_MSG_CHECKING([for presence of qt specs directory ${fuma_ax_qt_specs_dir}])
AS_IF([test -d "${fuma_ax_qt_specs_dir}"],
        [fuma_ax_have_qt_specs="yes"],
        [fuma_ax_have_qt_specs="no"])
AC_MSG_RESULT([$fuma_ax_have_qt_specs])

dnl Crap out if we cant find QT Headers
    AS_IF(dnl
        [test "x$fuma_ax_have_qt_header" = "xno"],[
        AC_ERROR([
            Error:  We couldnt find the QT headers to include
            -------------------------------------------------
            Fix: pass absolute path to QT header
            -------------------------------------------------
            export QT_DIR=${fuma_ax_qt_header_dir}
            ./configure --with-qt-include-dir=${QT_DIR}/include
            -------------------------------------------------
            Reason: The --with-qt-include-dir argument to configure is required, its probably missing.
            It should point to your QT installation.
            -------------------------------------------------
            ])dnl
        ]dnl
        )

dnl setup compiler flags
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CFLAGS="${QT_CFLAGS} -pipe"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CFLAGS="$QT_CFLAGS -Wall"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CFLAGS="$QT_CFLAGS -W"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} ${QT_HOST_CPPFLAGS}"])

dnl setup preprocessor flags
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} -I${fuma_ax_qt_header_dir}"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} -DQT_NO_DEBUG"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} -DQT_GUI_LIB"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} -DQT_CORE_LIB"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} -DQT_NETWORK_LIB"])
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"],[QT_CPPFLAGS="${QT_CPPFLAGS} ${QT_HOST_CPPFLAGS}"])

dnl dont turn the QT 'qt_shared' preprocessor flag on unless we are linking dynamically
    AS_IF([test "x$fuma_ax_have_qt_header" = "xyes"], [
            AS_IF([ test "x$enable_shared" = "xyes"], [QT_CPPFLAGS="${QT_CPPFLAGS} -DQT_SHARED"])
            ])


dnl Crap out if we cant find QT Specs
AS_IF(dnl
        [test "x$fuma_ax_have_qt_specs" = "xno"],[
        AC_ERROR([
            Error:  We couldnt find the QT specs to build against
            -------------------------------------------------
            Fix: pass absolute path to QT specs : we got fuma_ax_qt_specs_dir="$fuma_ax_qt_specs_dir"
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-specs-dir=${QT_DIR}/mkspecs
            -------------------------------------------------
            Reason: The --with-qt-specs-dir argument to configure is required, its probably missing.
            It should point to your QT Specs installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl setup path to spec directory
    AS_IF([test "x$fuma_ax_have_qt_specs" = "xyes"],[QT_SPECS_DIR="${fuma_ax_qt_specs_dir}"])

dnl setup darwain preprocessor flags for mkspecs directory
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_specs_dir/macx-g++"])

dnl setup config.h define
    AC_DEFINE([HAVE_QT_SPECS], [1], [Do we have QT Specs headers])

    AC_SUBST([QT_SPECS_DIR])

dnl pull in the host cflags for qt
    AS_IF([test "x$darwin"   = "xtrue"],[m4_include([m4/darwin/qt_cflags.m4])])
    AS_IF([test "x$linux"    = "xtrue"],[m4_include([m4/unix/qt_cflags.m4])])
    AS_IF([test "x$windows"  = "xtrue"],[m4_include([m4/windows/qt_cflags.m4])])

dnl Crap out if we cant find QT Host CFLAGS
    AS_IF(dnl
        [test "x$QT_HOST_CFLAGS" = "x"],[
        AC_ERROR(["
            Error:  We couldnt find the QT_HOST_CFLAGS to use in compilation
            -------------------------------------------------
            Fix: check platform detection macros to ensure correct file in included from m4/qt/sdk_headers.m4
            -------------------------------------------------
            Reason: The QT_HOST_CFLAGS differ from platfrom to plaform so we need the right ones included.
            -------------------------------------------------"
            ])dnl
        ]dnl
        )


dnl Crap out if we cant find QT Host CPPFLAGS
    AS_IF(dnl
        [test "x$QT_HOST_CPPFLAGS" = "x"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT_HOST_CPPFLAGS to use in compilation
            -------------------------------------------------
            Fix: check platform detection macros to ensure correct file in included from m4/qt/sdk_headers.m4
            -------------------------------------------------
            Reason: The QT_HOST_CPPFLAGS differ from platfrom to plaform so we need the right ones included.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
        )

    dnl expose the composite flags to makefiles and configure
    AC_SUBST([QT_CFLAGS])
    AC_SUBST([QT_CPPFLAGS])
    AC_SUBST([QT_HOST_CFLAGS])
    AC_SUBST([QT_HOST_CPPFLAGS])

    dnl expose the composite flags to makefiles and configure
    AC_SUBST([QT_INCLUDES],["$QT_CFLAGS $QT_HOST_CFLAGS $QT_CPPFLAGS $QT_HOST_CPPFLAGS"])

dnl setup config.h define
    AC_DEFINE([HAVE_QT_HEADERS], [1], [Define to 1 if we have QT Headers])
#---------------------------------------------------------------
# FUMA_WITH_QT_HEADERS end
#---------------------------------------------------------------
])
