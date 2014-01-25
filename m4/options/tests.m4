dnl Add the --enable-tests arg
FUMA_AX_ARG_ENABLE([tests],[Enable Test Suite and require passing to complete distcheck],[-DTESTS=1],[-DTESTS=0])
AM_CONDITIONAL([TESTS], [test "x$tests" = "xtrue"])
