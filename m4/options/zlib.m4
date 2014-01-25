dnl Add the --with-zlib-lib-dir arg
AC_ARG_WITH([zlib-lib-dir], [AS_HELP_STRING([--with-zlib-lib-dir=/path/to/ZLIB/libs],[path to ZLIB libraries])],
        [fuma_ax_zlib_library_dir="${withval}"; have_zlib_library="yes";],
        [fuma_ax_zlib_library_dir=""; have_zlib_library=no;])

dnl Crap out if we cant find libZLIB
AS_IF(dnl
        [test "x$have_zlib_library" = "xno"],[
        AC_ERROR([dnl

            Error:  We couldnt find the ZLIB libraries to link against
            -------------------------------------------------
            Fix: pass absolute path to ZLIB library
            -------------------------------------------------
            export ZLIB_DIR=/path/to/zlib
            ./configure --with-zlib-lib-dir=${ZLIB_DIR}/lib
            -------------------------------------------------
            Reason: The --with-zlib-lib-dir argument to configure is required, its probably missing.
            It should point to your libzlib installation.
            -------------------------------------------------dnl

            ])dnl
        ]dnl
     )

dnl setup linker flags
AS_IF([test "x$have_zlib_library" = "xyes"],[ZLIB_LDFLAGS="-L${fuma_ax_zlib_library_dir}"])

dnl setup libary archives
AS_IF([test "x$have_zlib_library" = "xyes"],[ZLIB_LIBS="${fuma_ax_zlib_library_dir}/libz.la -lm"])

dnl setup config.h define
AC_DEFINE([HAVE_ZLIB_LIBS], [1], [Do we have libz])
