# Process this file with autoconf to produce a configure script.
AC_INIT(m17n-docs, 0.9, bugs-m17n-lib@m17n.org)
AM_INIT_AUTOMAKE(m17n-docs, 0.9)

AM_MAINTAINER_MODE

# Checks for programs.
AC_PROG_INSTALL

# Checks for source program files.
AC_ARG_WITH(m17nlib,
  [  --with-m17n-lib=DIR     directory of m17n-lib source files],
  M17NLIB="$withval")

if test "x$M17NLIB" = "x"; then
  if test -d ../m17n-lib; then
    M17NLIB=../m17n-lib
  elif test -d /usr/local/src/m17n-lib; then
    CHARMAPS=/usr/local/src/m17n-lib
  else
    CHARMAPS=
  fi
else :
fi

AC_SUBST(M17NLIB)

AC_CHECK_PROG(DOXYGEN, doxygen, yes, no)
AC_CHECK_PROG(RUBY, ruby, yes, no)
AC_CHECK_PROG(PLATEX, platex, yes, no)

AC_CONFIG_FILES([Makefile doxyfile])
AC_OUTPUT

# Print configuration message.
if test "$DOXYGEN" = "no"; then
  echo "Can't find a program \"doxygen\"!"
  exit 1
fi
if test "$RUBY" = "no"; then
  echo "Can't find a program \"ruby\"!"
  exit 1
fi
if test "$PLATEX" = "no"; then
  echo "Can't find a program \"platex\"!"
  exit 1
fi

echo "-------------------------------------------------------------"
echo "Configure to make documentations from the source files under:"
echo "  $M17NLIB/src/"
echo "-------------------------------------------------------------"
