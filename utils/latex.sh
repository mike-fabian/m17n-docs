#!/bin/sh
#							-*- coding: utf-8; -*-
# $1: target directory (usr/latex, ja/latex, or dev/latex)

umask 002
USR_JA_DEV=`dirname $1`
cp styles/m17n-lib.sty $1
cd $1
LATEX=latex
if [ $USR_JA_DEV = "ja" ] ; then
  LATEX=platex
  if [ -d /usr/local/teTeX/bin ] ; then
    PATH=/usr/local/teTeX/bin:$PATH
  fi
  echo '\\appendix' > app.tex
  sed -n -e '/コンパイル/,/include{m17nDBFormat}/ p' \
      -e '/Tutorial for writing/,/include{GFDL}/ p' \
      -e '/printindex/,$ p' < refman.tex >> app.tex
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/inputenc/ d' \
      -e '/コンパイル/,/include{GFDL}/ d' \
      -e '/chapter{ファイル}/,$ d' \
      -e '/newunicodechar/d' < refman.tex > m17n-lib.tex
  cat app.tex >> m17n-lib.tex
  rm -rf tmp
  mkdir tmp
  rm -rf tmp
elif [ $USR_JA_DEV = "dev" ] ; then
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/The m17n Library Module Index/,/pages/ d' \
      -e '/The m17n Library File Documentation/,/textprop_8c/ d' \
      -e '/The m17n Library Directory Documentation/,/dir_000001/ d' \
      -e 's/The m17n Library Page Documentation/Appendix/' \
      -e '/newunicodechar/d' \
    < refman.tex > m17n-lib.tex
else
  echo '\\appendix' > app.tex
  sed -n -e '/Print compile/,/include{GFDL}/ p' \
      -e '/printindex/,$ p' < refman.tex >> app.tex
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/Print compile/,/include{GFDL}/ d' \
      -e '/chapter{File Documentation}/,$ d' \
      -e '/newunicodechar/d' < refman.tex > m17n-lib.tex
fi
${LATEX} m17n-lib.tex
makeindex m17n-lib.idx
${LATEX} m17n-lib.tex
${LATEX} m17n-lib.tex
