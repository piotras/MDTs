AC_PREREQ(2.59)
AC_INIT([diabet],[1.0])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_SRCDIR(src/diab.vala)

AC_SUBST(DIABET_ABI_MAJOR, 1)
AC_SUBST(DIABET_ABI_MINOR, 0)

AM_INIT_AUTOMAKE([-Wno-portability])
m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])

LT_INIT

AM_MAINTAINER_MODE
GOBJECT_INTROSPECTION_CHECK([1.40.0])

AC_PROG_CC
AM_PROG_VALAC([0.24.0])
AC_PROG_INSTALL

PKG_CHECK_MODULES(DIABET, glib-2.0 gobject-2.0)

LIBS="$INTLLIBS $LIBS"

PATH="${PATH}:${prefix}/bin"

dnl Checks for header files.
AC_HEADER_STDC

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST

AC_MSG_CHECKING([if building for some Win32 platform])
case "$host" in
  *-*-mingw*|*-*-cygwin*)
    platform_win32=yes
    ;;
  *)
    platform_win32=no
    ;;
esac
AC_MSG_RESULT($platform_win32)
AM_CONDITIONAL(PLATFORM_WIN32, test x$platform_win32 = xyes)

LIBS="$LIBS $DIABET_LIBS"

AC_SUBST(LIBS)
AC_SUBST(VERSION)
AC_SUBST(VERSION_STRING)
AC_SUBST(LFLAGS)
AC_SUBST(DIABET_LIBS)
AC_SUBST(DIABET_CFLAGS)

AC_CONFIG_FILES([Makefile 
		 src/Makefile 
		 diabet.pc])
AC_OUTPUT
