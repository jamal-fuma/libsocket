dnl output if we are using the VERBOSE_BUILD feature
AC_DEFUN([FUMA_AX_FEATURE_VERBOSE_BUILD],[
#---------------------------------------------------------------
# FUMA_AX_FEATURE_VERBOSE_BUILD start
#---------------------------------------------------------------
        dnl output the features we configured against to screen/file
        FUMA_AX_WRITELN([        Verbose Build:    enabled:  '${verbose}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_FEATURE_VERBOSE_BUILD end
#---------------------------------------------------------------
        ])

dnl output if we are using the ARG_ENABLE_VERBOSE_BUILD feature
AC_DEFUN([FUMA_AX_ARG_ENABLE_VERBOSE_BUILD],[
#---------------------------------------------------------------
# FUMA_AX_ARG_ENABLE_VERBOSE_BUILD start
#---------------------------------------------------------------

        dnl add --enable-verbose
        FUMA_AX_ARG_ENABLE([verbose],[[$1]],[-DVERBOSE=1])

        dnl Turn off silent builds (default)
        m4_ifdef([AM_SILENT_RULES],[
            AS_IF([test "x${verbose}" = "xtrue"],
                [AM_SILENT_RULES([no])],
                [AM_SILENT_RULES([yes])])
            ])

#---------------------------------------------------------------
# FUMA_AX_ARG_ENABLE_VERBOSE_BUILD end
#---------------------------------------------------------------
        ])
