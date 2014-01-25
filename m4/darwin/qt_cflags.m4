dnl setup darwin compiler flags
AS_IF([test "x$darwin" = "xtrue"],[CFLAGS="$CFLAGS -g"])
AS_IF([test "x$darwin" = "xtrue"],[CFLAGS="$CFLAGS -gdwarf-2"])

dnl 10.5 linker and upwards
AS_IF([test "x$darwin" = "xtrue"],[CFLAGS="$CFLAGS -mmacosx-version-min=10.6"])
AS_IF([test "x$darwin" = "xtrue"],[CFLAGS="$CFLAGS -isysroot /Developer/SDKs/MacOSX10.6.sdk"])
dnl 64-bit builds only
AS_IF([test "x$darwin" = "xtrue"],[CFLAGS="$CFLAGS -arch x86_64"])
AS_IF([test "x$darwin" = "xtrue"],[CFLAGS="$CFLAGS -Xarch_x86_64"])

AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CFLAGS="$QT_HOST_CFLAGS ${CFLAGS}"])

dnl Crap out if we cant find QT spec directory
    AS_IF([test "x$QT_SPECS_DIR" = "x"],[
        AC_ERROR([

            Error:  We couldnt find the QT_SPECS_DIR to use in compilation
            -------------------------------------------------
            Fix: check qt_sdk_headers.m4 it should be handled prior to the inclusion of this file m4/darwin/qt_cflags.m4
            -------------------------------------------------
            Reason: 
                    --with-qt-include-dir argument to configure needs to be processed prior to here as we use its value as a default
            -------------------------------------------------
            ])dnl
        ]dnl
        )

dnl setup darwain preprocessor flags for mkspecs directory
dnl commented as not working here AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_specs_dir/macx-g++"])

dnl include the arch specific framework headers
AS_IF([ test "x$enable_static" = "xno"],[
        AS_IF([test "x$darwin" = "xtrue"],[QT_ARCH_DEPENDANT_HEADER_DIR=".framework/Versions/4/Headers"])
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_library_dir/QtCore$QT_ARCH_DEPENDANT_HEADER_DIR"])
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_library_dir/QtGui$QT_ARCH_DEPENDANT_HEADER_DIR"])
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_library_dir/QtNetwork$QT_ARCH_DEPENDANT_HEADER_DIR"])
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -Wl,-F$fuma_ax_qt_library_dir"])
])

dnl include the arch independant headers
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir/QtCore"])
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir/QtGui"])
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir/QtNetwork"])
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS="$QT_HOST_CPPFLAGS -I$fuma_ax_qt_header_dir"])

dnl replace all references to " -F" to " -Wl,-F" as they cause the linker to choke on osx
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CFLAGS=`   echo "$QT_HOST_CFLAGS"    | sed 's/^-F/-Wl,-F/;s/ -F/ -Wl,-F/g'`])
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_CPPFLAGS=` echo "$QT_HOST_CPPFLAGS"  | sed 's/^-F/-Wl,-F/;s/ -F/ -Wl,-F/g'`])
