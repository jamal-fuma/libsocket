dnl build a distribution directory tree
AS_IF([test "x$darwin"  = "xtrue"],[prefix="${prefix}"])

dnl we distribute the headers of the libraries shipped seperately
AS_IF([test "x$darwin"  = "xtrue"],[includedir="${prefix}/include"])

dnl build a osx app bundle directory tree
AS_IF([test "x$darwin"  = "xtrue"],[exec_prefix="${prefix}/${PACKAGE_NAME}.app/Contents"])
AS_IF([test "x$darwin"  = "xtrue"],[bindir="${exec_prefix}/MacOS"])
AS_IF([test "x$darwin"  = "xtrue"],[libdir="${exec_prefix}/Frameworks"])

dnl ship any resources that the application would need in the resources directory tree
AS_IF([test "x$darwin"  = "xtrue"],[datarootdir="${exec_prefix}/Resources"])
AS_IF([test "x$darwin"  = "xtrue"],[datadir="${datarootdir}"])
AS_IF([test "x$darwin"  = "xtrue"],[mandir="${datarootdir}/man"])
AS_IF([test "x$darwin"  = "xtrue"],[infodir="${datarootdir}/info"])
AS_IF([test "x$darwin"  = "xtrue"],[docdir="${datarootdir}/doc/${PACKAGE}"])
