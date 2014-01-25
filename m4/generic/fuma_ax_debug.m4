dnl output if we are using the DEBUG feature
AC_DEFUN([FUMA_AX_FEATURE_DEBUG],[
#---------------------------------------------------------------
# FUMA_AX_FEATURE_DEBUG start
#---------------------------------------------------------------
        dnl output the features we configured against to screen/file
        FUMA_AX_WRITELN([        Debug Build:      enabled:  '${debug}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_FEATURE_DEBUG end
#---------------------------------------------------------------
        ])

dnl output if we are using the ARG_ENABLE_DEBUG feature
AC_DEFUN([FUMA_AX_ARG_ENABLE_DEBUG],[
#---------------------------------------------------------------
# FUMA_AX_ARG_ENABLE_DEBUG start
#---------------------------------------------------------------

        dnl add --enable-debug
        FUMA_AX_ARG_ENABLE([debug], [[$1]],
            [-DDEBUG=1 -UNDEBUG],
            [-DDEBUG=0 -DNDEBUG])

        dnl there must be a better way to 
        AS_IF([test "x${debug}" = "xtrue"],  [CFLAGS=`echo $CFLAGS | sed -e 's/-O2/-O0/'`])
        AS_IF([test "x${debug}" = "xfalse"], [CFLAGS=`echo $CFLAGS | sed -e 's/-g//'`])

        AM_CONDITIONAL([DEBUG], [test "x$debug" = "xtrue"])

#---------------------------------------------------------------
# FUMA_AX_ARG_ENABLE_DEBUG end
#---------------------------------------------------------------
        ])


dnl output if we are using the SQL_ENGINE feature
AC_DEFUN([FUMA_AX_FEATURE_SQL_ENGINE],[
#---------------------------------------------------------------
# FUMA_AX_FEATURE_SQL_ENGINE start
#---------------------------------------------------------------
        dnl output the features we configured against to screen/file
        FUMA_AX_WRITELN([        SQL Engine:       enabled:  '${fuma_ax_have_sqlite_library}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_FEATURE_SQL_ENGINE end
#---------------------------------------------------------------
        ])

dnl output if we are using the GRAPHICAL_USER_INTERFACE feature
AC_DEFUN([FUMA_AX_FEATURE_GRAPHICAL_USER_INTERFACE],[
#---------------------------------------------------------------
# FUMA_AX_FEATURE_GRAPHICAL_USER_INTERFACE start
#---------------------------------------------------------------
        dnl output the features we configured against to screen/file
        FUMA_AX_WRITELN([        GUI Build:        enabled:  '${fuma_ax_have_qt_library}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_FEATURE_GRAPHICAL_USER_INTERFACE end
#---------------------------------------------------------------
        ])

dnl list configured features
AC_DEFUN([FUMA_AX_FEATURES],[
#---------------------------------------------------------------
# FUMA_AX_FEATURES start
#---------------------------------------------------------------
        FUMA_AX_WRITELN([${as_nl}Features:],[$1])

        dnl are we building in debug mode
        FUMA_AX_FEATURE_DEBUG([$1])
        FUMA_AX_FEATURE_VERBOSE_BUILD([$1])
        FUMA_AX_FEATURE_TEST_SUITE([$1])
        FUMA_AX_FEATURE_SQL_ENGINE([$1])
        FUMA_AX_FEATURE_GRAPHICAL_USER_INTERFACE([$1])
#---------------------------------------------------------------
# FUMA_AX_FEATURES end
#---------------------------------------------------------------
        ])
