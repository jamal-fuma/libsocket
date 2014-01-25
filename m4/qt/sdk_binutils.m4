# FUMA_WITH_QT_BINUTILS
# ---------------------------------------------------------------
# Add the --with-qt-binutils-dir arg
# also add the --with-qt-binutils-dir arg with a defaults of the same directory as passed for lib but with a change from some-path/lib to  some-path/bin
# ---------------------------------------------------------------
# sets following variables for configure and make
# ---------------------------------------------------------------
# QT_TOOL_QMAKE    - makefile variable used in Makefile.am as $(QT_TOOL_QMAKE)          QT Makefile Generator
# QT_TOOL_UIC      - makefile variable used in Makefile.am as $(QT_TOOL_UIC)            QT User Inteface Compiler
# QT_TOOL_RCC      - makefile variable used in Makefile.am as $(QT_TOOL_RCC)            QT Resource Compiler
# QT_TOOL_MOC      - makefile variable used in Makefile.am as $(QT_TOOL_MOC)            QT Meta-Object Compiler
# ---------------------------------------------------------------
#       fuma_ax_qt_binutils_dir         - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_binutils_dir
#       fuma_ax_have_qt_binutils        - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_binutils
# ---------------------------------------------------------------
#       fuma_ax_qt_tool_qmake_binary    - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_tool_qmake_binary
#       fuma_ax_have_qt_tool_qmake      - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_tool_qmake
# ---------------------------------------------------------------
#       fuma_ax_qt_tool_uic_binary      - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_tool_uic_binary
#       fuma_ax_have_qt_tool_uic        - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_tool_uic
# ---------------------------------------------------------------
#       fuma_ax_qt_tool_rcc_binary      - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_tool_rcc_binary
#       fuma_ax_have_qt_tool_rcc        - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_tool_rcc
# ---------------------------------------------------------------
#       fuma_ax_qt_tool_moc_binary      - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_tool_moc_binary
#       fuma_ax_have_qt_tool_moc        - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_tool_moc
# ---------------------------------------------------------------
#       fuma_ax_qt_binutils_dir         - shell variable used in configure scripts and Makefile.am as $fuma_ax_qt_binutils_dir
#       fuma_ax_have_qt_binutils        - shell variable used in configure scripts and Makefile.am as $fuma_ax_have_qt_binutils
# ---------------------------------------------------------------
# sets following variables for config.h
# ---------------------------------------------------------------
# defines HAVE_QT_BINUTILS to 1 if QT Binary Utilities were found
# ---------------------------------------------------------------
AC_DEFUN([FUMA_WITH_QT_BINUTILS],
[dnl
#---------------------------------------------------------------
# FUMA_WITH_QT_BINUTILS start
#---------------------------------------------------------------
dnl print the user message if they specifed one
    AS_IF([test "x$1" != "x"],[AC_MSG_CHECKING([$1])])


dnl set the fuma_ax_have_qt_binutils flag based on the existance of the specifed/computed spec directory
AS_IF([test -d "$fuma_ax_qt_binutils_dir"],[fuma_ax_have_qt_binutils="yes"],[fuma_ax_have_qt_binutils="no"])


dnl Crap out if we cant find QT tools
AS_IF(dnl
        [test "x$fuma_ax_have_qt_binutils" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT tools (moc,uic and friends) to build against
            -------------------------------------------------
            Fix: pass absolute path to QT bin dir
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-binutils-dir=${QT_DIR}/bin
            -------------------------------------------------
            Reason: The --with-qt-binutils-dir argument to configure is required, its probably missing.
            It should point to your QT Tools installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl setup path to binutils directory
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"],[QT_BINUTILS_DIR="${fuma_ax_qt_binutils_dir}"])

dnl work out the path to QT's qmake
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"],[fuma_ax_qt_tool_qmake_binary="${fuma_ax_qt_binutils_dir}/qmake"])

dnl set the fuma_ax_have_qt_tool_qmake flag based on the existance of the specifed/computed executable
AS_IF([test -x $fuma_ax_qt_tool_qmake_binary],[fuma_ax_have_qt_tool_qmake="yes"],[fuma_ax_have_qt_tool_qmake="no"])
AS_IF([test "x$fuma_ax_have_qt_tool_qmake" = "xyes"],[QT_TOOL_QMAKE="${fuma_ax_qt_tool_qmake_binary}"])

dnl Crap out if we cant find QMake
AS_IF(dnl
        [test "x$fuma_ax_have_qt_tool_qmake" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT QMake tool to build projects with
            -------------------------------------------------
            Fix: pass absolute path to QT bin dir ensuring it contains a working QMake binary
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-binutils-dir=${QT_DIR}/bin
            -------------------------------------------------
            Reason: The --with-qt-binutils-dir argument to configure is required, its probably missing.
            It should point to your qmake binary which is located in the bin directory of your QT SDK installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )
dnl setup darwin qmake flags
AS_IF([test "x$darwin" = "xtrue"],[QT_TOOL_QMAKE_FLAGS="$QT_TOOL_QMAKE_FLAGS -spec macx-g++"])
AS_IF([test "x$windows" = "xtrue"],[
        AC_ERROR([dnl
            Error:  We didnt write the build for windows yet
            -------------------------------------------------
            Fix: find m4/qt/skd_binutils.m4 and fix it.
            -------------------------------------------------
            ])dnl
 ])
AS_IF([test "x$linux" = "xtrue"],[
        AC_ERROR([dnl
            Error:  We didnt write the build for linux yet
            -------------------------------------------------
            Fix: find m4/qt/skd_binutils.m4 and fix it.
            -------------------------------------------------
            ])dnl
 ])

dnl expose QMake
AC_SUBST([QT_TOOL_QMAKE],[$fuma_ax_qt_tool_qmake_binary])
AC_SUBST([QT_TOOL_QMAKE_FLAGS])

dnl work out the path to QT's moc
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"],[fuma_ax_qt_tool_moc_binary="${fuma_ax_qt_binutils_dir}/moc"])

dnl set the fuma_ax_have_qt_tool_moc flag based on the existance of the specifed/computed executable
AS_IF([test -x $fuma_ax_qt_tool_moc_binary],[fuma_ax_have_qt_tool_moc="yes"],[fuma_ax_have_qt_tool_moc="no"])
AS_IF([test "x$fuma_ax_have_qt_tool_moc" = "xyes"],[QT_TOOL_MOC="$fuma_ax_qt_tool_moc_binary"])

dnl Crap out if we cant find MOC
AS_IF(dnl
        [test "x$fuma_ax_have_qt_tool_moc" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT MOC tool to build projects with
            -------------------------------------------------
            Fix: pass absolute path to QT bin dir ensuring it contains a working MOC binary
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-binutils-dir=${QT_DIR}/bin
            -------------------------------------------------
            Reason: The --with-qt-binutils-dir argument to configure is required, its probably missing.
            It should point to your qmake binary which is located in the bin directory of your QT SDK installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl expose MOC
AC_SUBST([QT_TOOL_MOC])

dnl work out the path to QT's uic
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"],[fuma_ax_qt_tool_uic_binary="${fuma_ax_qt_binutils_dir}/uic"])

dnl set the fuma_ax_have_qt_tool_uic flag based on the existance of the specifed/computed executable
AS_IF([test -x $fuma_ax_qt_tool_uic_binary],[fuma_ax_have_qt_tool_uic="yes"],[fuma_ax_have_qt_tool_uic="no"])
AS_IF([test "x$fuma_ax_have_qt_tool_uic" = "xyes"],[QT_TOOL_UIC="$fuma_ax_qt_tool_uic_binary"])

dnl Crap out if we cant find UIC
AS_IF(dnl
        [test "x$fuma_ax_have_qt_tool_uic" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT UIC tool to build projects with
            -------------------------------------------------
            Fix: pass absolute path to QT bin dir ensuring it contains a working UIC binary
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-binutils-dir=${QT_DIR}/bin
            -------------------------------------------------
            Reason: The --with-qt-binutils-dir argument to configure is required, its probably missing.
            It should point to your qmake binary which is located in the bin directory of your QT SDK installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl expose UIC
AC_SUBST([QT_TOOL_UIC])

dnl work out the path to QT's rcc
AS_IF([test "x$fuma_ax_have_qt_binutils" = "xyes"],[fuma_ax_qt_tool_rcc_binary="${fuma_ax_qt_binutils_dir}/rcc"])

dnl set the fuma_ax_have_qt_tool_rcc flag based on the existance of the specifed/computed executable
AS_IF([test -x $fuma_ax_qt_tool_rcc_binary],[fuma_ax_have_qt_tool_rcc="yes"],[fuma_ax_have_qt_tool_rcc="no"])
AS_IF([test "x$fuma_ax_have_qt_tool_rcc" = "xyes"],[QT_TOOL_RCC="$fuma_ax_qt_tool_rcc_binary"])

dnl Crap out if we cant find RCC
AS_IF(dnl
        [test "x$fuma_ax_have_qt_tool_rcc" = "xno"],[
        AC_ERROR([dnl
            Error:  We couldnt find the QT RCC tool to build projects with
            -------------------------------------------------
            Fix: pass absolute path to QT bin dir ensuring it contains a working RCC binary
            -------------------------------------------------
            export QT_DIR=/path/to/qt
            ./configure --with-qt-binutils-dir=${QT_DIR}/bin
            -------------------------------------------------
            Reason: The --with-qt-binutils-dir argument to configure is required, its probably missing.
            It should point to your qmake binary which is located in the bin directory of your QT SDK installation.
            -------------------------------------------------dnl
            ])dnl
        ]dnl
     )

dnl expose RCC
AC_SUBST([QT_TOOL_RCC])

dnl setup config.h define
AC_DEFINE([HAVE_QT_BINUTILS], [1], [Do we have QT Binary Utilities (moc,uic and friends)])

#---------------------------------------------------------------
# FUMA_WITH_QT_BINUTILS end
#---------------------------------------------------------------
])
