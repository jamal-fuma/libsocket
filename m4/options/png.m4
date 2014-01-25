dnl Add the --with-png-lib-dir arg
AC_ARG_WITH([png-lib-dir], [AS_HELP_STRING([--with-png-lib-dir=/path/to/PNG/libs],[path to PNG libraries])],
        [fuma_ax_png_library_dir="${withval}"; have_png_library="yes";],
        [fuma_ax_png_library_dir=""; have_png_library=no;])

dnl Crap out if we cant find libPNG
AS_IF(dnl
        [test "x$have_png_library" = "xno"],[dnl
        AC_ERROR([dnl
            Error:  We couldnt find the PNG libraries to link against
            -------------------------------------------------
            Fix: pass absolute path to PNG library
            -------------------------------------------------
            export PNG_DIR=/path/to/png
            ./configure --with-png-lib-dir=${PNG_DIR}/lib
            -------------------------------------------------
            Reason: The --with-png-lib-dir argument to configure is required, its probably missing.
            It should point to your libpng installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl setup linker flags
AS_IF([test "x$have_png_library" = "xyes"],[PNG_LDFLAGS="-L${fuma_ax_png_library_dir}";])

dnl setup libary archives
AS_IF([test "x$have_png_library" = "xyes"],[PNG_LIBS="${fuma_ax_png_library_dir}/libpng.la -lm"])

dnl setup config.h define
AC_DEFINE([HAVE_PNG_LIBS], [1], [Do we have libpng])
