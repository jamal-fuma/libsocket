AC_DEFUN([FUMA_AX_QT_FRAMEWORK_LIBRARIES],[
#---------------------------------------------------------------
# FUMA_AX_QT_FRAMEWORK_LIBRARIES start
#---------------------------------------------------------------

        framework_name="[$1]"
        framework_dir="[$2]"
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_LIBS="$QT_HOST_LIBS -Wl,-F${framework_dir}"])
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_LIBS="$QT_HOST_LIBS -L${framework_dir}"])
        AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_LIBS="$QT_HOST_LIBS -framework ${framework_name}"])
#---------------------------------------------------------------
# FUMA_AX_QT_FRAMEWORK_LIBRARIES end
#---------------------------------------------------------------
])

AC_DEFUN([FUMA_AX_QT_PLATFORM_LIBRARIES],[
#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_LIBRARIES start
#---------------------------------------------------------------
        dnl dynamically link against Qt's dependencies
        QT_HOST_LIBS="$QT_HOST_LIBS /usr/local/lib/libjpeg.a"
        QT_HOST_LIBS="$QT_HOST_LIBS /usr/local/lib/libtiff.a"
        QT_HOST_LIBS="$QT_HOST_LIBS /usr/local/lib/libpng15.a"

        dnl dynamically link against Qt's system dependencies
        QT_HOST_LIBS="$QT_HOST_LIBS -lz"
        QT_HOST_LIBS="$QT_HOST_LIBS -lm"

        dnl dynamically link against Qt's platform dependencies
        FUMA_AX_QT_FRAMEWORK_LIBRARIES([ApplicationServices],[/System/Library/Frameworks])
        FUMA_AX_QT_FRAMEWORK_LIBRARIES([CoreFoundation],[/System/Library/Frameworks])
        FUMA_AX_QT_FRAMEWORK_LIBRARIES([Security],[/System/Library/Frameworks])
        FUMA_AX_QT_FRAMEWORK_LIBRARIES([Carbon],[/System/Library/Frameworks])
        FUMA_AX_QT_FRAMEWORK_LIBRARIES([AppKit],[/System/Library/Frameworks])
#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_LIBRARIES end
#---------------------------------------------------------------
])

AC_DEFUN([FUMA_AX_QT_PLATFORM_LDFLAGS],[
#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_LDFLAGS start
#---------------------------------------------------------------
        dnl dynamically link against Qt's dependencies
        QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -L/usr/local/lib"
        QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -L/usr/X11/lib"
        QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -L/usr/lib"
        QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -L/System/Library/Frameworks"

#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_LDFLAGS end
#---------------------------------------------------------------
        ])

AC_DEFUN([FUMA_AX_QT_PLATFORM_STATIC],[
#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_STATIC start
#---------------------------------------------------------------

            dnl statically link against Qt, remember to ship main.o for licence compliance
            QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Wl,-install_name,@executable_path/../Frameworks/"

            dnl statically link against Qt, remember to ship main.o for licence compliance
            QT_HOST_LIBS="$QT_HOST_LIBS ${fuma_ax_qt_library_dir}/libQtGui.a"
            QT_HOST_LIBS="$QT_HOST_LIBS ${fuma_ax_qt_library_dir}/libQtCore.a"
            QT_HOST_LIBS="$QT_HOST_LIBS ${fuma_ax_qt_library_dir}/libQtNetwork.a"

            dnl dynamically link against Qt's dependencies
            FUMA_AX_QT_PLATFORM_LDFLAGS
            FUMA_AX_QT_PLATFORM_LIBRARIES

#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_STATIC end
#---------------------------------------------------------------
        ])


AC_DEFUN([FUMA_AX_QT_PLATFORM_SHARED],[
#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_SHARED start
#---------------------------------------------------------------
            dnl dynamically link against Qt
dnl            QT_HOST_LDFLAGS="$QT_HOST_LDFLAGS -Xlinker -rpath -Xlinker ${libdir}"

            FUMA_AX_QT_FRAMEWORK_LIBRARIES([QtCore],[${fuma_ax_qt_library_dir}])
            FUMA_AX_QT_FRAMEWORK_LIBRARIES([QtGui],[${fuma_ax_qt_library_dir}])
            FUMA_AX_QT_FRAMEWORK_LIBRARIES([QtNetwork],[${fuma_ax_qt_library_dir}])
#---------------------------------------------------------------
# FUMA_AX_QT_PLATFORM_SHARED end
#---------------------------------------------------------------
        ])

dnl setup darwin libraries
AS_IF([test "x$darwin" = "xtrue"], [
        dnl setup darwin linker flags
        LDFLAGS="$LDFLAGS -Wl,-headerpad_max_install_names"
        dnl this conflicts with -r option
        LDFLAGS="$LDFLAGS -Wl,-dead_strip_dylibs"
        LDFLAGS="$LDFLAGS -Wl,-no_function_starts"
        LDFLAGS="$LDFLAGS -Wl,-no_version_load_command"

        dnl setup QT host linker flags
        QT_HOST_LDFLAGS="$LDFLAGS"
        export MACOSX_DEPLOYMENT_TARGET=10.6

        dnl pull in QT libraries
        AS_IF([ test "x$enable_static" = "xyes"],
            [FUMA_AX_QT_PLATFORM_STATIC],
            [FUMA_AX_QT_PLATFORM_SHARED])

        dnl genrate a rpath relative to the executable foo.App/Contents for resolved dynamic library
        dnl AS_IF([test "x$darwin" = "xtrue"],[LDFLAGS="$LDFLAGS -Wl,-rpath,@executable_path/../Frameworks"])

        dnl genrate a rpath relative to the loading library executable foo.App/Contents for resolved dynamic library
        dnl AS_IF([test "x$darwin" = "xtrue"],[LDFLAGS="$LDFLAGS -Wl,-rpath,@loader_path/."])
        ])

dnl fix a libtool bug on OSx
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_LDFLAGS=`echo "$QT_HOST_LDFLAGS" | sed 's/^-F/-Wl,-F/;s/ -F/ -Wl,-F/g'`])
AS_IF([test "x$darwin" = "xtrue"],[QT_HOST_LIBS=`   echo "$QT_HOST_LIBS"    | sed 's/^-F/-Wl,-F/;s/ -F/ -Wl,-F/g'`])
