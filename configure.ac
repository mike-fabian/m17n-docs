# Process this file with autoconf to produce a configure script.
AC_INIT(m17n-docs, 0.9, bugs-m17n-lib@m17n.org)
AM_INIT_AUTOMAKE(m17n-docs, 0.9)

AM_MAINTAINER_MODE

# Checks for programs.
AC_PROG_INSTALL

if test $USE_MAINTAINER_MODE = yes; then

# Checks for source program files.
AC_ARG_WITH(m17nlib,
  [  --with-m17n-lib=DIR     directory of m17n-lib source files],
  M17NLIB="$withval")

if test "x$M17NLIB" = "x"; then
  if test -d ../m17n-lib; then
    M17NLIB=../m17n-lib
  elif test -d /usr/local/src/m17n-lib; then
    M17NLIB=/usr/local/src/m17n-lib
  else
    M17NLIB=.
  fi
else :
fi

AC_SUBST(M17NLIB)

AC_CHECK_PROG(HAVEDOXYGEN, doxygen, yes, no)
AC_CHECK_PROG(RUBY, ruby, yes, no)
AC_CHECK_PROG(LATEX, latex, yes, no)
AC_CHECK_PROG(PLATEX, platex, yes, no)

OK=yes
if test "$HAVEDOXYGEN" = "no"; then
  echo "Can't find a program \"doxygen\"!"
  OK=no
fi
if test "$RUBY" = "no"; then
  echo "Can't find a program \"ruby\"!"
  OK=no
fi
if test "$LATEX" = "no"; then
  echo "Can't find a program \"latex\"!"
  OK=no
fi
if test "$PLATEX" = "no"; then
  echo "Can't find a program \"platex\"!"
  OK=no
fi
if test "$OK" = "no"; then
  exit 1
fi

fi

AC_CONFIG_FILES(Makefile)
AC_OUTPUT

# Print configuration message.
echo "-------------------------------------------------------------"
echo "Configure to make documentations from the source files under:"
echo "  $M17NLIB/src/"
echo "-------------------------------------------------------------"
