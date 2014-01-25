dnl Add the --with-tiff-lib-dir arg
m4_include([tiff.m4])

dnl Add the --with-jpeg-lib-dir arg
m4_include([jpeg.m4])

dnl Add the --with-png-lib-dir arg
m4_include([png.m4])

dnl Add the --with-zlib-lib-dir arg
m4_include([zlib.m4])

dnl setup makefile defines for libPNG
AC_SUBST([PNG_LDFLAGS])
AC_SUBST([PNG_LIBS])

dnl setup makefile defines for libJPEG
AC_SUBST([JPEG_LDFLAGS])
AC_SUBST([JPEG_LIBS])

dnl setup makefile defines for libTIFF
AC_SUBST([TIFF_LDFLAGS])
AC_SUBST([TIFF_LIBS])

dnl setup makefile defines for libZLIB
AC_SUBST([ZLIB_LDFLAGS])
AC_SUBST([ZLIB_LIBS])

AC_DEFUN([FUMA_SYSTEM_LIBRARY_BANNER],[dnl
#---------------------------------------------------------------
# FUMA_SYSTEM_LIBRARY_BANNER start
#---------------------------------------------------------------
dnl  Compile banner
echo \
"-------------------------------------------------
${PACKAGE_NAME} Version ${PACKAGE_VERSION}

Host:     '${host}'.
Prefix:   '${prefix}'.
Compiler: '${CC} ${CFLAGS} ${CPPFLAGS} ${LDFLAGS}'

Linker:             ${LDFLAGS}
CFlags:             ${CFLAGS}
CPPFlags:           ${CPPFLAGS}

Package features:
Debug:              ${debug}
Tests:              ${tests}

Darwin:             '${darwin}'
Unix:               '${unix}'
Windows:            '${windows}'

TIFF Libraries:
                    --with-tiff-lib-dir='${fuma_ax_tiff_library_dir}'
                    TIFF_LDFLAGS                =       '${TIFF_LDFLAGS}'
                    TIFF_LIBS                   =       '${TIFF_LIBS}'
JPEG Libraries:
                    --with-jpeg-lib-dir='${fuma_ax_jpeg_library_dir}'
                    JPEG_LDFLAGS                =       '${JPEG_LDFLAGS}'
                    JPEG_LIBS                   =       '${JPEG_LIBS}'
PNG Libraries:
                    --with-png-lib-dir='${fuma_ax_png_library_dir}'
                    PNG_LDFLAGS                 =       '${PNG_LDFLAGS}'
                    PNG_LIBS                    =       '${PNG_LIBS}'
ZLIB Libraries:
                    --with-zlib-lib-dir='${fuma_ax_zlib_library_dir}'
                    ZLIB_LDFLAGS                =       '${ZLIB_LDFLAGS}'
                    ZLIB_LIBS                   =       '${ZLIB_LIBS}'

./configure --host='${host}' \\
    --with-tiff-lib-dir='${fuma_ax_tiff_library_dir}' \\
    --with-jpeg-lib-dir='${fuma_ax_jpeg_library_dir}' \\
    --with-png-lib-dir='${fuma_ax_png_library_dir}'   \\
    --with-zlib-lib-dir='${fuma_ax_zlib_library_dir}'
-------------------------------------------------"

#---------------------------------------------------------------
# FUMA_SYSTEM_LIBRARY_BANNER end
#---------------------------------------------------------------
])
