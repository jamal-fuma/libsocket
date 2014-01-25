dnl Add the --with-darwin-binutils-dir default argument of "/usr/bin"
AS_IF([test "x$darwin"  = "xtrue"],[
        AC_ARG_WITH([darwin-binutils-dir],[
            AS_HELP_STRING([--with-darwin-binutils-dir=/usr/bin] ,[path to DARWIN binutils])],
            [fuma_ax_darwin_binutils_dir="${withval}"],
            [fuma_ax_darwin_binutils_dir="/usr/bin"])
        ])

dnl Add the --with-darwin-binutils-otool default argument of "${fuma_ax_darwin_binutils_dir}/otool"
AS_IF([test "x$darwin"  = "xtrue"],[
        AC_ARG_WITH([darwin-binutils-otool],
            [AS_HELP_STRING([-with-darwin-binutils-otool=/usr/bin/otool] ,[path to DARWIN binutils (otool) ])],
            [fuma_ax_darwin_binutils_otool_binary="${withval}"],
            [fuma_ax_darwin_binutils_otool_binary="${fuma_ax_darwin_binutils_dir}/otool"])
])

dnl set the fuma_ax_have_qt_binutils flag based on the existance of the specifed/computed directory
AS_IF([test -d "$fuma_ax_darwin_binutils_dir"],[fuma_ax_have_darwin_binutils="yes"],[fuma_ax_have_darwin_binutils="no"])
AS_IF([test -x "$fuma_ax_darwin_binutils_otool_binary"],[fuma_ax_have_darwin_binutils="yes"],[fuma_ax_have_darwin_binutils="no"])
dnl find the otool binary utility controlled
dnl configure flag:    --with-darwin-binutils-otool
dnl configure default: "${fuma_ax_darwin_binutils_dir}/otool"

dnl check the path to DARWIN_TOOL_OTOOL on darwin
AS_IF([test "x$darwin"  = "xtrue"],[

        dnl check the path to DARWIN_TOOL_OTOOL
        AC_CHECK_PROG([DARWIN_TOOL_OTOOL],              dnl Variable
            [otool],                                    dnl program to find
            ["$fuma_ax_darwin_binutils_otool_binary"],  dnl absolute path of the tool to use on success
            [missing],                                  dnl error value
            ["$fuma_ax_darwin_binutils_dir"]            dnl set PATH="this directory", in otherwords search this directory for tool
            )

        dnl set a flag if the path to DARWIN_TOOL_OTOOL is bogus
        AS_IF([test "x$ac_cv_prog_otool"  = "xmissing"],
            [fuma_ax_have_darwin_binutils_otool="no"],
            [fuma_ax_have_darwin_binutils_otool="yes"])

        dnl declare the variable as precious see http://www.delorie.com/gnu/docs/autoconf/autoconf_83.html
        AC_ARG_VAR([DARWIN_TOOL_OTOOL],[path to DARWIN binutils (otool) ])
    ])

dnl crap out if the path to DARWIN_TOOL_OTOOL is bogus as a bonus does the platform detection
dnl as fuma_ax_have_darwin_binutils_otool is only set on darwin
AS_IF([test "x$fuma_ax_have_darwin_binutils_otool"  = "xno"],[
        AC_ERROR([
            -------------------------------------------------
            Error: We couldnt find a ${host} operating system specific tool in the path:
            -------------------------------------------------
            Fix  : pass absolute path to 'otool' binary
            -------------------------------------------------
./configure --with-darwin-binutils-otool=/usr/bin/otool
            -------------------------------------------------
            Reason: The --with-darwin-binutils-dir argument to configure is required, its probably missing.
            It should point to your Tools installation, try '/usr/bin'

            -------------------------------------------------])
        ])

AC_SUBST([DARWIN_BINUTILS_DIR],["$fuma_ax_darwin_binutils_dir"])
