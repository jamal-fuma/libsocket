# we need a build platform which has the C preprocessor defined __STDC__ defined to a non-zero value
AC_HEADER_STDC

dnl ANSI C is now supported by almost all the widely used compilers.
dnl Most of the C code being written nowadays is based on ANSI C.
dnl Any program written only in standard C and without any hardware dependent assumptions
dnl is virtually guaranteed to compile correctly on any platform with
dnl a conforming C implementation.
AC_CHECK_HEADERS([stdint.h])
AC_CHECK_HEADERS([limits.h])
AC_CHECK_HEADERS([float.h])
AC_CHECK_HEADERS([stddef.h])
AC_CHECK_HEADERS([string.h])

# this means all bets are off unless we have a build platform which has the C preprocessor defined __STDC__ defined to a non-zero value
dnl Without such precautions, most programs may compile only on a certain platform
dnl or with a particular compiler, due, for example, to the use of non-standard libraries,
dnl such as GUI libraries, or to the reliance on compiler- or platform-specific attributes
dnl such as the exact size of certain data types and byte endianness.
AC_CHECK_HEADERS([sys/types.h])

# C99 header
AC_CHECK_HEADERS([inttypes.h])

dnl we ship a replacement for strndup if it not present in system libc
AC_REPLACE_FUNCS([strndup])

dnl we are not shipping replacements for these
AC_CHECK_FUNCS([memmove])
AC_CHECK_FUNCS([memset])
AC_CHECK_FUNCS([strchr])
AC_CHECK_FUNCS([strtol])
AC_CHECK_FUNCS([strtoul])

# common funcs across windows and unix
# we probably want to use the windows specific version on that platform
AC_CHECK_FUNCS([getenv setenv])
