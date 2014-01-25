dnl Add the --with-tiff-lib-dir arg
AC_ARG_WITH([tiff-lib-dir], [AS_HELP_STRING([--with-tiff-lib-dir=/path/to/TIFF/libs],[path to TIFF libraries])],
        [fuma_ax_tiff_library_dir="${withval}"; have_tiff_library="yes";],
        [fuma_ax_tiff_library_dir=""; have_tiff_library=no;])

dnl Crap out if we cant find libTIFF
AS_IF(dnl
        [test "x$have_tiff_library" = "xno"],[
        AC_ERROR([dnl

            Error:  We couldnt find the TIFF libraries to link against
            -------------------------------------------------
            Fix: pass absolute path to TIFF library
            -------------------------------------------------
            export TIFF_DIR=/path/to/tiff
            ./configure --with-tiff-lib-dir=${TIFF_DIR}/lib
            -------------------------------------------------
            Reason: The --with-tiff-lib-dir argument to configure is required, its probably missing.
            It should point to your libtiff installation.
            -------------------------------------------------dnl

            ])dnl
        ]dnl
     )

dnl setup linker flags
AS_IF([test "x$have_tiff_library" = "xyes"],[TIFF_LDFLAGS="-L${fuma_ax_tiff_library_dir}";])

dnl setup libary archives
AS_IF([test "x$have_tiff_library" = "xyes"],[TIFF_LIBS="${fuma_ax_tiff_library_dir}/libtiff.la -lm"])

dnl setup config.h define
AC_DEFINE([HAVE_TIFF_LIBS], [1], [Do we have libtiff])
