#!/bin/sh
#							-*- coding: euc-jp; -*-
# $1: target directory (usr/latex, ja/latex, or dev/latex)
# $2: latex commnad (latex, platex, or pdflatex)

umask 002
USR_JA_DEV=`dirname $1`
TEXINPUTS=`pwd`/styles:`pwd`/data-${USR_JA_DEV}:.:
export TEXINPUTS
cd $1
LATEX=$2
if [ $USR_JA_DEV = "ja" ] ; then
  LATEX=platex
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/M17N �饤�֥�� �⥸�塼�����/,/pages/ d' \
      -e '/M17N �饤�֥�� �ե�����β���/,/textprop_8c/ d' \
      -e 's/M17N �饤�֥�� �ڡ����β���/Appendix/' \
    < refman.tex > m17n-lib.tex
else
  sed -e '/documentclass/ s/a4paper/a4paper,twoside/' \
      -e '/The M17N Library Module Index/,/pages/ d' \
      -e '/The M17N Library File Documentation/,/textprop_8c/ d' \
      -e 's/The M17N Library Page Documentation/Appendix/' \
    < refman.tex > m17n-lib.tex
fi
${LATEX} m17n-lib.tex
if [ "${USR_JA_DEV}" = "ja" ] ; then
  nkf -e < m17n-lib.idx > temp.idx; mv temp.idx m17n-lib.idx
fi
makeindex m17n-lib.idx
${LATEX} m17n-lib.tex
