dnl FUMA_AX_SED([required-code-to-evaluate],[required-sed-expression-to-evaluate],[optional file-to-append])
dnl output the passed text (\$1) to screen or to file (\$2)
AC_DEFUN([FUMA_AX_SED],[

# ---------------------------------------------------------------
# FUMA_AX_SED start
# ---------------------------------------------------------------

        # output the passed text (first argument) to file unless Filename (second argument) was empty
        AS_IF([test "x$3" != "x"],[
            (
                $1
            ) | ${SED} "$2" >> "$3" ;dnl
            ])

        # output the passed text (first argument) to file unless Filename (second argument) was empty
        AS_IF([test "x$2" != "x"],[
            (
                $1
            ) | ${SED} "$2" ;dnl
            ])

#---------------------------------------------------------------
# FUMA_AX_SED end
#---------------------------------------------------------------
            ])


dnl FUMA_AX_WRITE([required data-to-write],[optional file-to-append])
dnl output the passed text (\$1) to screen or to file (\$2) without appending a newline
AC_DEFUN([FUMA_AX_WRITE],[

# ---------------------------------------------------------------
# FUMA_AX_WRITE start
# ---------------------------------------------------------------
        dnl replace newlines escapes with literal newlines
        dnl replace_newlines_escapes_with_literal_newlines=['s:\\n::g']
        replace_newlines_escapes_with_literal_newlines=["s:\\n:\n:g"]
        FUMA_AX_SED([printf "%s" "$1"],[[$replace_newlines_escapes_with_literal_newlines]],[$2])

#---------------------------------------------------------------
# FUMA_AX_WRITE end
#---------------------------------------------------------------
            ])

dnl FUMA_AX_WRITELN([required data-to-write],[optional file-to-append])
dnl output the passed text (\$1) to screen or to file (\$2) appending a newline
AC_DEFUN([FUMA_AX_WRITELN],[

# ---------------------------------------------------------------
# FUMA_AX_WRITELN start
# ---------------------------------------------------------------

            # output the passed text to screen or to file appending a newline
            FUMA_AX_WRITE([[$1$as_nl]],[[$2]])

#---------------------------------------------------------------
# FUMA_AX_WRITELN end
#---------------------------------------------------------------
    ])
