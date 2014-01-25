dnl leave symbols in libraries
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CFLAGS="$QT_HOST_CFLAGS -g"])

dnl setup windows compiler flags
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CFLAGS="$QT_HOST_CFLAGS -Wall -W"])

dnl setup darwain preprocessor flags for mkspecs directory
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$QT_SPECS_DIR/win32-g++"])

dnl include the arch specific framework headers
AS_IF([test "x$windows" = "xtrue"],[QT_ARCH_DEPENDANT_HEADER_DIR=""])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_library_dir/QtCore$QT_ARCH_DEPENDANT_HEADER_DIR"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_library_dir/QtGui$QT_ARCH_DEPENDANT_HEADER_DIR"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_library_dir/QtNetwork$QT_ARCH_DEPENDANT_HEADER_DIR"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -L$fuma_ax_qt_library_dir"])

dnl include the arch independant headers
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir/QtCore"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir/QtGui"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir/QtNetwork"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir"])
