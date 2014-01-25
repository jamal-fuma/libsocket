dnl output if we are using the ARG_ENABLE feature
dnl FUMA_AX_ARG_ENABLE([required-name-of-argument-to-add],[required-help-message],[optional-cppflags-if-enabled],[optional cppflags-if-disabled])
AC_DEFUN([FUMA_AX_ARG_ENABLE],[
#---------------------------------------------------------------
# FUMA_AX_ARG_ENABLE start
#---------------------------------------------------------------

# Add the --enable-$1 arg

        dnl Add a --enable-xxx argument to the configure script
        AC_ARG_ENABLE([$1],[
            AS_HELP_STRING([--enable-$1], [$2])],
            [$1="true"],
            [$1="false"])

        dnl conditionally append last argument to CPPFLAGS if enabled
        FUMA_AX_CPPFLAGS_IF_ENABLED([$1],[$3])

        dnl conditionally append last argument to CPPFLAGS if disabled
        FUMA_AX_CPPFLAGS_IF_DISABLED([$1],[$4])

#---------------------------------------------------------------
# FUMA_AX_ARG_ENABLE end
#---------------------------------------------------------------
        ])
