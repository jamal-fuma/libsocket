AC_DEFUN([FUMA_AX_BUILD],[
#---------------------------------------------------------------
# FUMA_AX_BUILD start
#---------------------------------------------------------------
        FUMA_AX_WRITELN([${FUMA_AX_RELEASE_TEXT}],[$1])
        FUMA_AX_WRITELN([Build environment '${FUMA_APPLICATION_RELEASE_TEXT}'],[$1])
        FUMA_AX_WRITELN([        Compiler:           CC       '${CC}'],[$1])
        FUMA_AX_WRITELN([        CFlags:             CFLAGS   '${CFLAGS}'],[$1])
        FUMA_AX_WRITELN([        CPPFlags:           CPPFLAGS '${CPPFLAGS}'],[$1])
        FUMA_AX_WRITELN([        Linker:             LDFLAGS  '${LDFLAGS}'],[$1])

        dnl list configured features
        FUMA_AX_FEATURES($1)

        FUMA_AX_WRITELN([        Darwin Binutils:  enabled:  '${fuma_ax_have_darwin_binutils_otool}' DARWIN_BINUTILS_DIR='${DARWIN_BINUTILS_DIR}'],[$1])
        FUMA_AX_WRITELN([        Darwin Binary Utils:          --with-darwin-binutils-dir='${fuma_ax_darwin_binutils_dir}'],[$1])

        FUMA_AX_WRITELN([Event Loop: '${LIBEVENT2_SDK_RELEASE}'],[$1])
        FUMA_AX_WRITELN([        Event Loop Headers:           --with-libevent2-include-dir='${fuma_ax_libevent2_header_dir}'],[$1])
        FUMA_AX_WRITELN([        Event Loop Libraries:         --with-libevent2-lib-dir='${fuma_ax_libevent2_library_dir}'],[$1])

        FUMA_AX_WRITELN([SQL Engine: '${SQLITE_SDK_RELEASE}'],[$1])
        FUMA_AX_WRITELN([        SQL Engine Headers:           --with-sqlite-include-dir='${fuma_ax_sqlite_header_dir}'],[$1])
        FUMA_AX_WRITELN([        SQL Engine Libraries:         --with-sqlite-lib-dir='${fuma_ax_sqlite_library_dir}'],[$1])

        FUMA_AX_WRITELN([GUI Framework: '${QT_SDK_RELEASE}'],[$1])
        FUMA_AX_WRITELN([        GUI Framework Headers:        --with-qt-include-dir='${fuma_ax_qt_header_dir}'],[$1])
        FUMA_AX_WRITELN([        GUI Framework Libraries:      --with-qt-lib-dir='${fuma_ax_qt_library_dir}'],[$1])
        FUMA_AX_WRITELN([        GUI Binary Utils:             --with-qt-binutils-dir='${fuma_ax_qt_binutils_dir}'],[$1])
        FUMA_AX_WRITELN([            otool DARWIN_TOOL_OTOOL='${DARWIN_TOOL_OTOOL}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_BUILD end
#---------------------------------------------------------------
])
