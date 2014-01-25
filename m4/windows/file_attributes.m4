# file attributes on windows
AC_CHECK_HEADERS([winbase.h])
AC_CHECK_FUNCS([GetFileAttributesA SetFileAttributesA])
