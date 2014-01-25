# process handling unix
AC_CHECK_HEADERS([unistd.h sys/types])

dnl forms our getpid replacement
AC_REPLACE_FUNCS([getpid])

dnl replacements for the system types
AC_TYPE_PID_T
AC_TYPE_MODE_T
AC_TYPE_OFF_T
AC_TYPE_UID_T
