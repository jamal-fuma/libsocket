# process handling windows
AC_CHECK_HEADERS([windows.h process.h])

dnl forms our getpid replacement
AC_CHECK_FUNCS([GetCurrentProcessId])

dnl replacements for the system types
AC_TYPE_PID_T
AC_TYPE_MODE_T
AC_TYPE_OFF_T
AC_TYPE_UID_T
