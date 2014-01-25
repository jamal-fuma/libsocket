dnl Add the --with-qt-dir arg
AC_ARG_WITH([qt-dir],
        [AS_HELP_STRING([--with-qt-dir=/path/to/QT],[path to QT libraries/headers/binutils])],
        [fuma_ax_qt_dir="${withval}"],
        [fuma_ax_qt_dir="/usr/local/Trolltech/Qt-4.8.4"])

dnl Add the --with-qt-lib-dir arg
AC_ARG_WITH([qt-lib-dir], [AS_HELP_STRING([--with-qt-lib-dir=/path/to/QT/libs],[path to QT libraries])],
        [fuma_ax_qt_library_dir="${withval}"],
        [fuma_ax_qt_library_dir="${fuma_ax_qt_dir}/lib"])

dnl Add the --with-qt-include-dir arg
AC_ARG_WITH([qt-include-dir], [AS_HELP_STRING([--with-qt-include-dir=/path/to/QT/Headers],[path to QT Headers])],
        [fuma_ax_qt_header_dir="${withval}"],
        [fuma_ax_qt_header_dir="${fuma_ax_qt_dir}/include"])

dnl Add the --with-qt-binutils-dir arg
AC_ARG_WITH([qt-binutils-dir],[AS_HELP_STRING([--with-qt-binutils-dir=/path/to/QT/binutils],[Pass absolute path to QT binutils])],
        [fuma_ax_qt_binutils_dir="${withval}"],
        [fuma_ax_qt_binutils_dir="$fuma_ax_qt_dir/bin"])

dnl Add the --with-qt-specs-dir arg
AC_ARG_WITH([qt-specs-dir], [AS_HELP_STRING([--with-qt-specs-dir=/path/to/QT/specs], [Pass absolute path to QT specs])],
        [fuma_ax_qt_specs_dir="${withval}"],
        [fuma_ax_qt_specs_dir="${fuma_ax_qt_dir}/mkspecs"])

dnl Add the --with-qt-binutils-dir arg
AC_ARG_WITH([qt-binutils-dir],[AS_HELP_STRING([--with-qt-binutils-dir=/path/to/QT/binutils],
            [Pass absolute path to QT binutils])],
        [fuma_ax_qt_binutils_dir="${withval}"],
        [fuma_ax_qt_binutils_dir="$fuma_ax_qt_binutils_dir"])

dnl Add the --with-qt-include-dir arg
m4_include([m4/qt/sdk_headers.m4])
FUMA_WITH_QT_HEADERS([Processing --with-qt-include-dir argument])

dnl add the --with-qt-lib-dir option
m4_include([m4/qt/sdk_libraries.m4])
FUMA_WITH_QT_LIBRARIES([Processing --with-qt-lib-dir argument])

dnl add the --with-qt-binutils-dir option
m4_include([m4/qt/sdk_binutils.m4])
FUMA_WITH_QT_BINUTILS([Processing --with-qt-binutils-dir argument])

dnl work out QT_SDK_VERSION by asking QMake
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"], [QT_SDK_VERSION=`    $QT_TOOL_QMAKE -query QT_VERSION | sed '/^.*\([0-9]\.[0-9]\.[0-9]\).*$/!d;         s//\1/;' `])

dnl work out QT_SDK_VER_MAJOR by asking QMake and stripping the minor version
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"], [QT_SDK_VER_MAJOR=`  $QT_TOOL_QMAKE -query QT_VERSION | sed '/^.*\([0-9]\)\.\([0-9]\.[0-9]\).*$/!d;     s//\1/;' `])

dnl work out QT_SDK_VER_MINOR by asking QMake and stripping the major version
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"], [QT_SDK_VER_MINOR=`  $QT_TOOL_QMAKE -query QT_VERSION | sed '/^.*\([0-9]\)\.\([0-9]\.[0-9]\).*$/!d;     s//\2/;' `])

# build QT release string
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"], [QT_SDK_RELEASE="Built against QT ${QT_SDK_VER_MAJOR}.${QT_SDK_VER_MINOR}"])

dnl remember the basedir setting for distcheck builds
AS_IF([test "x$fuma_ax_have_qt_directory" = "xyes"],[
    FUMA_BUILD_OPTIONS="${FUMA_BUILD_OPTIONS} --with-qt-dir=${fuma_ax_qt_dir}"
])

# expose the version information
AC_SUBST([QT_SDK_VERSION])
AC_SUBST([QT_SDK_VER_MAJOR])
AC_SUBST([QT_SDK_VER_MINOR])
AC_SUBST([QT_SDK_RELEASE])
