dnl file attributes on unix use the st_mode member of struct stat which is mode_t
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_HEADERS([sys/types.h sys/stat.h])])
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_HEADERS([fcntl.h])])
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_HEADERS([sys/file.h])])
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_HEADERS([sys/ioctl.h])])
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_HEADERS([sys/mount.h])])
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_HEADERS([sys/param.h])])

dnl we need stat(2) and chmod(2) for permissions checks
AS_IF([test "x$unix" = "xtrue"],[AC_TYPE_MODE_T])

dnl we need stuct stat.st_mode for permissions checks
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_MEMBER(
        [struct stat.st_mode],
        [AC_DEFINE(HAVE_STAT_ST_MODE,, Define if stat.st_mode )],
        [AC_MSG_ERROR(['We need stat.st_mode'])],
        [
#include <sys/types.h>
#include <sys/stat.h>
        ])])

dnl we need stuct stat.st_blksize for sqlite block checks
AS_IF([test "x$unix" = "xtrue"],[AC_CHECK_MEMBERS([struct stat.st_blksize])])
