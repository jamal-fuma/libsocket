dnl setup windows linker flags
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Wl,-enable-auto-import"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Wl,-enable-runtime-pseudo-reloc"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Wl,-enable-stdcall-fixup"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Wl,-s"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Wl,-subsystem,windows"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -mthreads"])

dnl setup windows linker flags
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lmingw32"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lqtmain"])

dnl setup windows gdi layer
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lgdi32"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lglu32"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lopengl32"])

dnl setup windows userspace / shell api
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lshlwapi"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -luser32"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -luserenv"])

dnl setup windows networking
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lnetapi3"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lwinsock3"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -lws2_32"])

dnl setup libary archives
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtCore.la"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtGui.la"])
AS_IF([test "x$windows" = "xtrue"],[QT_HOST_LIBS="${QT_HOST_LIBS} ${fuma_ax_qt_library_dir}/QtNetwork.la"])
