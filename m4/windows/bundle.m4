dnl build a distribution directory tree
AS_IF([test "x$windows"  = "xtrue"],[prefix="${prefix}"])

dnl we distribute the headers of the libraries shipped seperately
AS_IF([test "x$windows"  = "xtrue"],[includedir="${prefix}/include"])

dnl build a osx app bundle directory tree
AS_IF([test "x$windows"  = "xtrue"],[exec_prefix="${prefix}/${PACKAGE_NAME}.app/Contents"])
AS_IF([test "x$windows"  = "xtrue"],[exec_prefix="${prefix}"])
AS_IF([test "x$windows"  = "xtrue"],[bindir="${exec_prefix}/Windows"])
AS_IF([test "x$windows"  = "xtrue"],[libdir="${exec_prefix}/Libraries"])

dnl ship any resources that the application would need in the resources directory tree
AS_IF([test "x$windows"  = "xtrue"],[datarootdir="${exec_prefix}/Resources"])
AS_IF([test "x$windows"  = "xtrue"],[datadir="${datarootdir}"])
AS_IF([test "x$windows"  = "xtrue"],[mandir="${datarootdir}/man"])
AS_IF([test "x$windows"  = "xtrue"],[infodir="${datarootdir}/info"])
AS_IF([test "x$windows"  = "xtrue"],[docdir="${datarootdir}/doc/${PACKAGE}"])
