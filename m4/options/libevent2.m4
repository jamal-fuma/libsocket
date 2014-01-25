dnl Add the --with-libevent2-dir arg
AC_ARG_WITH([libevent2-dir],
        [AS_HELP_STRING([--with-libevent2-dir=/path/to/LIBEVENT2],[path to LIBEVENT2 libraries/headers/binutils])],
        [fuma_ax_libevent2_dir="${withval}"],
        [fuma_ax_libevent2_dir="/usr"])

dnl Add the --with-libevent2-lib-dir arg
AC_ARG_WITH([libevent2-lib-dir], [AS_HELP_STRING([--with-libevent2-lib-dir=/path/to/LIBEVENT2/libs],[path to LIBEVENT2 libraries])],
        [fuma_ax_libevent2_library_dir="${withval}"],
        [fuma_ax_libevent2_library_dir="${fuma_ax_libevent2_dir}/lib"])

dnl Add the --with-libevent2-include-dir arg
AC_ARG_WITH([libevent2-include-dir], [AS_HELP_STRING([--with-libevent2-include-dir=/path/to/LIBEVENT2/Headers],[path to LIBEVENT2 Headers])],
        [fuma_ax_libevent2_header_dir="${withval}"],
        [fuma_ax_libevent2_header_dir="${fuma_ax_libevent2_dir}/include"])

dnl Add the --with-libevent2-include-dir arg
m4_include([m4/libevent2/sdk_headers.m4])
FUMA_WITH_LIBEVENT2_HEADERS([Processing --with-libevent2-include-dir argument])

dnl add the --with-libevent2-lib-dir option
m4_include([m4/libevent2/sdk_libraries.m4])
FUMA_WITH_LIBEVENT2_LIBRARIES([Processing --with-libevent2-lib-dir argument])

