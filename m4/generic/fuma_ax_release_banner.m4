AC_DEFUN([FUMA_AX_QT_BANNER],[
#---------------------------------------------------------------
# FUMA_AX_BANNER start
#---------------------------------------------------------------
        dnl output all the relevent stuff
        FUMA_AX_WRITELN([        QT Headers:         --with-qt-include-dir='${fuma_ax_qt_header_dir}'],[$1])
        FUMA_AX_WRITELN([        ---------------------------------------------------------------],[$1])
        FUMA_AX_WRITELN([        QT_CFLAGS                   =       '${QT_CFLAGS}'],[$1])
        FUMA_AX_WRITELN([        QT_CPPFLAGS                 =       '${QT_CPPFLAGS}'],[$1])
        FUMA_AX_WRITELN([        QT_HOST_CFLAGS              =       '${QT_HOST_CFLAGS}'],[$1])
        FUMA_AX_WRITELN([        QT_HOST_CPPFLAGS            =       '${QT_HOST_CPPFLAGS}'],[$1])
        FUMA_AX_WRITELN([        QT Libraries:       --with-qt-lib-dir='${fuma_ax_qt_library_dir}'],[$1])
        FUMA_AX_WRITELN([        ---------------------------------------------------------------],[$1])
        FUMA_AX_WRITELN([        QT_LDFLAGS                  =       '${QT_LDFLAGS}'],[$1])
        FUMA_AX_WRITELN([        QT_LIBS                     =       '${QT_LIBS}'],[$1])
        FUMA_AX_WRITELN([        QT Binary Utils:    --with-qt-binutils-dir='${fuma_ax_qt_binutils_dir}'],[$1])
        FUMA_AX_WRITELN([        ---------------------------------------------------------------],[$1])
        FUMA_AX_WRITELN([        QT_BINUTILS_DIR             =       '${QT_BINUTILS_DIR}'],[$1])
        FUMA_AX_WRITELN([        QT_TOOL_QMAKE               =       '${QT_TOOL_QMAKE}'],[$1])
        FUMA_AX_WRITELN([        QT_TOOL_UIC                 =       '${QT_TOOL_UIC}'],[$1])
        FUMA_AX_WRITELN([        QT_TOOL_RCC                 =       '${QT_TOOL_RCC}'],[$1])
        FUMA_AX_WRITELN([        QT_TOOL_MOC                 =       '${QT_TOOL_MOC}'],[$1])
#---------------------------------------------------------------
# FUMA_AX_QT_BANNER end
#---------------------------------------------------------------
])

AC_DEFUN([FUMA_AX_BANNER],[
#---------------------------------------------------------------
# FUMA_AX_BANNER start
#---------------------------------------------------------------

        FUMA_AX_BUILD([$1])

        FUMA_AX_QT_BANNER([$1])

        FUMA_AX_WRITELN([./configure ],[$1])
        FUMA_AX_WRITELN([        --host='${host}' ],[$1])
        FUMA_AX_WRITELN([        --prefix='${prefix}' ],[$1])
        FUMA_AX_WRITELN([        --with-darwin-binutils-dir='${fuma_ax_darwin_binutils_dir}'  ],[$1])
        FUMA_AX_WRITELN([        --with-darwin-binutils-otool='${fuma_ax_darwin_binutils_otool_binary}'  ],[$1])
        FUMA_AX_WRITELN([        --with-sqlite-include-dir='${fuma_ax_sqlite_header_dir}'     ],[$1])
        FUMA_AX_WRITELN([        --with-sqlite-lib-dir='${fuma_ax_sqlite_library_dir}'        ] ,[$1])
        FUMA_AX_WRITELN([        --with-qt-include-dir='${fuma_ax_qt_header_dir}'     ],[$1])
        FUMA_AX_WRITELN([        --with-qt-lib-dir='${fuma_ax_qt_library_dir}'        ],[$1])
        FUMA_AX_WRITELN([        --with-qt-binutils-dir='${fuma_ax_qt_binutils_dir}'],[$1])

        FUMA_AX_DISTRIBUTION([$1])

#---------------------------------------------------------------
# FUMA_AX_BANNER end
#---------------------------------------------------------------
])
