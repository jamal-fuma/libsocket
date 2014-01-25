AC_DEFUN([FUMA_AX_PLATFORM],[
#---------------------------------------------------------------
# FUMA_AX_PLATFORM start
#---------------------------------------------------------------

        FUMA_AX_CANONICAL_HOST

        dnl setup installtion directory for osx
        AS_IF([test "x$darwin" = "xtrue"],[m4_include([m4/darwin/bundle.m4])])
        AS_IF([test "x$darwin" = "xtrue"],[m4_include([m4/darwin/binutils.m4])])

        dnl setup installtion directory for windows
        AS_IF([test "x$windows" = "xtrue"],[m4_include([m4/windows/bundle.m4])])

        AS_IF([test "x$unix" = "xtrue"],[m4_include([m4/unix/username.m4])])
        AS_IF([test "x$unix" = "xtrue"],[m4_include([m4/unix/stat.m4])])
        AS_IF([test "x$unix" = "xtrue"],[m4_include([m4/unix/sqlite.m4])])
        AS_IF([test "x$unix" = "xtrue"],[m4_include([m4/unix/process_handling.m4])])

        dnl username / file attributes on windows
        AS_IF([test "x$windows" = "xtrue"],[m4_include([m4/windows/process_handling.m4])])
        AS_IF([test "x$windows" = "xtrue"],[m4_include([m4/windows/username.m4])])
        AS_IF([test "x$windows" = "xtrue"],[m4_include([m4/windows/file_attributes.m4])])

        case "${fuma_ax_build_platform}" in 
        *OSX*)
        dnl add darwin specific arguments to configure
        ;;

        *LINUX*)
        dnl add linux specific arguments to configure
        ;;

        *Windows*)
        dnl add windows specific arguments to configure
        ;;
    *) 
        AC_ERROR([Unsupported operating system: ${host} ${fuma_ax_build_platform}])
    ;; 
    esac

AC_MSG_RESULT([Configuring for ${fuma_ax_build_platform} Deployment with build host: ${host}])

#---------------------------------------------------------------
# FUMA_AX_PLATFORM end
#---------------------------------------------------------------
    ])
