dnl platform detection
AC_DEFUN([FUMA_AX_CANONICAL_HOST],[
#---------------------------------------------------------------
# FUMA_AX_CANONICAL_HOST start
#---------------------------------------------------------------

        dnl set the host triplet
        AC_CANONICAL_HOST

        dnl set our platform flag
        case "${host}" in 
            *-*-darwin*)                darwin=true; unix=true; fuma_ax_build_platform="UNIX (OSX)"    ;;
            *-*-linux*)                 linux=true;  unix=true; fuma_ax_build_platform="UNIX (LINUX)"  ;;
            *-*-mingw32*)               windows=true ; fuma_ax_build_platform="Windows (MINGW_W32)"  ;;
            *-*-mingw64*)               windows=true ; fuma_ax_build_platform="Windows (MINGW_W64)"  ;;
            *-*-win32*)                 windows=true ; fuma_ax_build_platform="Windows (MS_W32)"  ;;
            *-*-win64*)                 windows=true ; fuma_ax_build_platform="Windows (MS_W64)"  ;;
            *)                          unknown_build=true      ;;
        esac

        dnl grab date of build
        fuma_ax_build_date="Built on : `date | cut -c 1-24`"

        dnl produce a unique version string for this build
        fuma_ax_build_version="Version (${PACKAGE_VERSION}) ${fuma_ax_build_date}"

        dnl make sure the name of the app is used in the build version
        fuma_ax_build_label="${PACKAGE_NAME} ${fuma_ax_build_platform} ${fuma_ax_build_version}"

        # enable the POSIX specific portions of the makefile
        AM_CONDITIONAL([UNIX], [test "x$unix" = "xtrue"])

        # enable the LINUX specific portions of the makefile
        AM_CONDITIONAL([LINUX], [test "x$linux" = "xtrue"])

        # enable the OSX specific portions of the makefile
        AM_CONDITIONAL([DARWIN], [test "x$darwin" = "xtrue"])

        # enable the Windows specific portions of the makefile
        AM_CONDITIONAL([WINDOWS],[test "x$windows" = "xtrue"])

        # add in some flags to choose platform specific makefile
        FUMA_AX_CPPFLAGS_IF_ENABLED([unix],[-DUNIX=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([linux],[-DLINUX=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([darwin],[-DDARWIN=1])
        FUMA_AX_CPPFLAGS_IF_ENABLED([windows],[-DWINDOWS=1])

#---------------------------------------------------------------
# FUMA_AX_CANONICAL_HOST end
#---------------------------------------------------------------
        ])
