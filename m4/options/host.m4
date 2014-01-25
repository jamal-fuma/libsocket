FUMA_AX_PLATFORM

dnl make some config.h defines
AC_DEFINE_UNQUOTED([FUMA_AX_BUILD_DATE], ["$fuma_ax_build_date"], [Application Build Date])

AC_DEFINE_UNQUOTED([FUMA_AX_BUILD_VERSION], ["$fuma_ax_build_version"], [Application Build Version])

AC_DEFINE_UNQUOTED([FUMA_AX_BUILD_LABEL], ["$fuma_ax_build_label"], [Application Build Label])

dnl add them to the substitutions list
AC_SUBST([FUMA_AX_BUILD_DATE])

AC_SUBST([FUMA_AX_BUILD_LABEL])

AC_SUBST([FUMA_AX_BUILD_VERSION])
