dnl date parsing
AC_CHECK_HEADERS([time.h sys/types.h sys/time.h])
AC_HEADER_TIME
AC_STRUCT_TM

AC_CHECK_FUNCS([gettimeofday])
AC_CHECK_FUNCS([localtime_r])
AC_CHECK_FUNCS([clock_gettime])

dnl this form the backbone of our RFC2616 implementation so we ship a replacement for mingw platfroms
AC_REPLACE_FUNCS([strptime])
dnl http://git.videolan.org/gitweb.cgi/vlc/vlc-2.0.git/?p=vlc/vlc-2.0.git;a=blob;f=compat/getpid.c;h=29469828badf4208f7529c495b29aef3b787620a;hb=e9ebc6b2c4f3741333f5bc8c58b0e0e041dd22fa
