dnl Add the --with-jpeg-lib-dir arg
AC_ARG_WITH([jpeg-lib-dir], [AS_HELP_STRING([--with-jpeg-lib-dir=/path/to/JPEG/libs],[path to JPEG libraries])],
        [fuma_ax_jpeg_library_dir="${withval}"; have_jpeg_library="yes";],
        [fuma_ax_jpeg_library_dir=""; have_jpeg_library=no;])

dnl Crap out if we cant find libJPEG
AS_IF(dnl
        [test "x$have_jpeg_library" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the JPEG libraries to link against
            -------------------------------------------------
            Fix: pass absolute path to JPEG library
            -------------------------------------------------
            export JPEG_DIR=/path/to/jpeg
            ./configure --with-jpeg-lib-dir=${JPEG_DIR}/lib
            -------------------------------------------------
            Reason: The --with-jpeg-lib-dir argument to configure is required, its probably missing.
            It should point to your libjpeg installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl setup linker flags
AS_IF([test "x$have_jpeg_library" = "xyes"],[JPEG_LDFLAGS="-L${fuma_ax_jpeg_library_dir}"])

dnl setup libary archives
AS_IF([test "x$have_jpeg_library" = "xyes"],[JPEG_LIBS="${fuma_ax_jpeg_library_dir}/libjpeg.la -lm"])

dnl setup config.h define
AC_DEFINE([HAVE_JPEG_LIBS], [1], [Do we have libjpeg])
