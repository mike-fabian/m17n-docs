#!/bin/sh
#							-*- coding: utf-8; -*-
# $1: target directory (usr/latex, ja/latex, or dev/latex)
# $2: latex commnad (latex, platex, or pdflatex)

umask 002
USR_JA_DEV=`dirname $1`
TEXINPUTS=`pwd`/styles:.:
export TEXINPUTS
cd $1
LATEX=$2
if [ $USR_JA_DEV = "ja" ] ; then
  LATEX=platex
  if [ -d /usr/local/teTeX/bin ] ; then
    PATH=/usr/local/teTeX/bin:$PATH
  fi
  SOURCE=m17n-lib-ja
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/m17n ライブラリ モジュール索引/,/pages/ d' \
      -e '/m17n ライブラリ ファイル/,/textprop_8c/ d' \
      -e '/m17n ライブラリ Directory Documentation/,/dir_000001/ d' \
      -e 's/m17n ライブラリ ページ/Appendix/' \
    < refman.tex > ${SOURCE}.tex
elif [ $USR_JA_DEV = "dev" ] ; then
  SOURCE=m17n-lib-dev
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/The m17n Library Module Index/,/pages/ d' \
      -e '/The m17n Library File Documentation/,/textprop_8c/ d' \
      -e '/The m17n Library Directory Documentation/,/dir_000001/ d' \
      -e 's/The m17n Library Page Documentation/Appendix/' \
    < refman.tex > ${SOURCE}.tex
else
  SOURCE=m17n-lib
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/The m17n Library Module Index/,/pages/ d' \
      -e '/The m17n Library File Documentation/,/textprop_8c/ d' \
      -e '/The m17n Library Directory Documentation/,/dir_000001/ d' \
      -e 's/The m17n Library Page Documentation/Appendix/' \
    < refman.tex > ${SOURCE}.tex
fi
${LATEX} ${SOURCE}.tex
#if [ "${USR_JA_DEV}" = "ja" ] ; then
#  nkf -e < ${SOURCE}.idx > temp.idx; mv temp.idx ${SOURCE}.idx
#fi
/usr/bin/makeindex ${SOURCE}.idx
${LATEX} ${SOURCE}.tex
${LATEX} ${SOURCE}.tex
