dnl Add the --with-sqlite-dir arg
AC_ARG_WITH([sqlite-dir],
        [AS_HELP_STRING([--with-sqlite-dir=/path/to/SQLITE],[path to SQLITE libraries/headers/binutils])],
        [fuma_ax_sqlite_dir="${withval}"],
        [fuma_ax_sqlite_dir="/usr"])

dnl Add the --with-sqlite-lib-dir arg
AC_ARG_WITH([sqlite-lib-dir], [AS_HELP_STRING([--with-sqlite-lib-dir=/path/to/SQLITE/libs],[path to SQLITE libraries])],
        [fuma_ax_sqlite_library_dir="${withval}"],
        [fuma_ax_sqlite_library_dir="${fuma_ax_sqlite_dir}/lib"])

dnl Add the --with-sqlite-include-dir arg
AC_ARG_WITH([sqlite-include-dir], [AS_HELP_STRING([--with-sqlite-include-dir=/path/to/SQLITE/Headers],[path to SQLITE Headers])],
        [fuma_ax_sqlite_header_dir="${withval}"],
        [fuma_ax_sqlite_header_dir="${fuma_ax_sqlite_dir}/include"])

dnl Add the --with-sqlite-include-dir arg
m4_include([m4/sqlite/sdk_headers.m4])
FUMA_WITH_SQLITE_HEADERS([Processing --with-sqlite-include-dir argument])

dnl add the --with-sqlite-lib-dir option
m4_include([m4/sqlite/sdk_libraries.m4])
FUMA_WITH_SQLITE_LIBRARIES([Processing --with-sqlite-lib-dir argument])
