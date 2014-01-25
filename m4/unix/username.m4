dnl user and group attributes on unix use uid_t and gid_t respectively
AC_TYPE_UID_T
AC_CHECK_HEADERS([unistd.h pwd.h])

dnl we need these for username operations
AC_CHECK_FUNCS([getpwuid getuid])

dnl we need stuct passwd.pw_dir for username checks
AC_CHECK_MEMBER(
        [struct passwd.pw_dir],
        [AC_DEFINE(HAVE_PASSWD_PW_DIR,, Define if passwd.pw_dir )],
        [AC_MSG_ERROR(['We need passwd.pw_dir'])],
        [
#include <unistd.h>
#include <pwd.h>
        ])
