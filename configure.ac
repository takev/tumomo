
AC_PREREQ(2.61)
AC_INIT(taula, 0.1, take.vos@vosgames.nl)
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([buildutils])
AM_INIT_AUTOMAKE()

dnl    Here are a set of rules to help you update your library version information:
dnl
dnl    * Start with version information of `0:0:0' for each libtool library.
dnl    * Update the version information only immediately before a public release of your software.
dnl      More frequent updates are unnecessary, and only guarantee that the current interface
dnl      number gets larger faster.
dnl    * If the library source code has changed at all since the last update, then increment revision
dnl      (`c:r:a' becomes `c:r+1:a').
dnl    * If any interfaces have been added, removed, or changed since the last update, increment current,
dnl      and set revision to 0.
dnl    * If any interfaces have been added since the last public release, then increment age.
dnl    * If any interfaces have been removed since the last public release, then set age to 0.
SHARED_VERSION_INFO=0:0:0
AC_SUBST(SHARED_VERSION_INFO)

AC_PROG_CC
AC_PROG_LEX
AC_PROG_YACC
AC_PROG_INSTALL
AM_PATH_PYTHON([2.5])

dnl PKG_PROG_PKG_CONFIG([0.1])
PKG_CHECK_MODULES([YYAST], [yyast >= 0.1])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile parser/Makefile boot/Makefile compiler/Makefile])
AC_OUTPUT

