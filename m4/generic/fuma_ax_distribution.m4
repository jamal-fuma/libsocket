dnl output the version of app we built to screen/file
AC_DEFUN([FUMA_AX_DISTRIBUTION],[
#---------------------------------------------------------------
# FUMA_AX_DISTRIBUTION start
#---------------------------------------------------------------
        dnl output the version of app we built to screen/file
        FUMA_AX_WRITELN([${FUMA_AX_RELEASE_TEXT}],[$1])
        dnl output the version of libraries we depend on to screen/file
        FUMA_AX_WRITELN([${QT_SDK_RELEASE}],[$1])
        FUMA_AX_WRITELN([${SQLITE_SDK_RELEASE}],[$1])

        dnl output features configured
        FUMA_AX_FEATURES([$1])

dnl output distro directory
        FUMA_AX_WRITELN([--------------------------------------------------------------],[$1])
        FUMA_AX_WRITELN([    /Distribution.zip],[$1])
        FUMA_AX_WRITELN([        /Installation Prefix:            '${prefix}'],[$1])
        FUMA_AX_WRITELN([            /Library Public Headers:     '${includedir}'],[$1])
        FUMA_AX_WRITELN([            /Executable Prefix:          '${exec_prefix}'],[$1])
        FUMA_AX_WRITELN([                /Directory for Binaries  '${bindir}'],[$1])
        FUMA_AX_WRITELN([                /Directory for Libraries '${libdir}'],[$1])
        FUMA_AX_WRITELN([                /Directory for Resources '${datarootdir}'],[$1])
        FUMA_AX_WRITELN([--------------------------------------------------------------],[$1])

#---------------------------------------------------------------
# FUMA_AX_DISTRIBUTION end
#---------------------------------------------------------------
])
