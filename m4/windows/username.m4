dnl user and group attributes on wins use DWORD and gid_t respectively
AC_CHECK_HEADERS([Shlobj.h])

dnl we need these for username operations
AC_CHECK_FUNCS([SHGetFolderPathA])

