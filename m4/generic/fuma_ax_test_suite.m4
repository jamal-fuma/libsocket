dnl output if we are using the TEST_SUITE feature
AC_DEFUN([FUMA_AX_FEATURE_TEST_SUITE],[
#---------------------------------------------------------------
# FUMA_AX_FEATURE_TEST_SUITE start
#---------------------------------------------------------------
        dnl output the features we configured against to screen/file
        FUMA_AX_WRITELN([        Test Suite:       enabled:  '${tests}' TESTS_ENVIRONMENT='${TESTS_ENVIRONMENT}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_FEATURE_TEST_SUITE end
#---------------------------------------------------------------
        ])
