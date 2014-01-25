dnl setup linux linker flags
AS_IF([test "x$linux" = "xtrue"],[QT_HOST_LDFLAGS="-L$fuma_ax_qt_library_dir"])

dnl setup libary archives
AS_IF([test "x$linux" = "xtrue"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtCore.la"])
AS_IF([test "x$linux" = "xtrue"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtGui.la"])
AS_IF([test "x$linux" = "xtrue"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtNetwork.la"])
