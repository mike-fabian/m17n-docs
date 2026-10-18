#!/bin/bash
#							-*- coding: utf-8; -*-
# $1: target directory (usr/latex, ja/latex, or dev/latex)

umask 002
USR_JA_DEV=`dirname $1`
cp styles/m17n-lib.sty $1
cd $1
LATEX=pdflatex
if [ $USR_JA_DEV = "ja" ] ; then
  echo -e '\\appendix' > app.tex
  sed -n -e '/コンパイル/,/input{m17nDBFormat}/ p' \
      -e '/Tutorial for writing/,/input{GFDL}/ p' \
      -e '/% Index/,$ p' < refman.tex >> app.tex
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/コンパイル/,/input{GFDL}/ d' \
      -e '/chapter{ファイル詳解}/,$ d' \
      -e '/\\def\\doxynewunicodechar#1#2{/,/^  }/d' \
      -e '/newunicodechar/d' \
      -e 's/ps2pdf,pagebackref=true/dvipdfmx,pagebackref=true/' \
    < refman.tex > m17n-lib.tex
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
      -e '/\\def\\doxynewunicodechar#1#2{/,/^  }/d' \
      -e '/newunicodechar/d' \
    < refman.tex > m17n-lib.tex
else
  echo -e '\\appendix' > app.tex
  sed -n -e '/Print compile/,/input{GFDL}/ p' \
      -e '/% Index/,$ p' < refman.tex >> app.tex
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/Print compile/,/input{GFDL}/ d' \
      -e '/chapter{File Documentation}/,$ d' \
      -e '/\\def\\doxynewunicodechar#1#2{/,/^  }/d' \
      -e '/newunicodechar/d' \
    < refman.tex > m17n-lib.tex
  cat app.tex >> m17n-lib.tex
fi
# These vietnamese charaters cause a problem in TeX.
sed -e '/Trần Ngọc Quân/s/Trần Ngọc Quân/Tran Ngoc Quân/' < m17nDBData.tex > temp.tex
mv temp.tex m17nDBData.tex

${LATEX} m17n-lib.tex
makeindex m17n-lib.idx
${LATEX} m17n-lib.tex
${LATEX} m17n-lib.tex
