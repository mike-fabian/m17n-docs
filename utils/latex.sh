#!/bin/sh
# $1: target directory (usr/latex, ja/latex, or dev/latex)
# $2: latex commnad (latex, platex, or pdflatex)

umask 002
USR_JA_DEV=`dirname $1`
TEXINPUTS=`pwd`/styles:`pwd`/data-${USR_JA_DEV}:.:
export TEXINPUTS
cd $1
LATEX=$2
${LATEX} m17n-lib.tex
if [ "${USR_JA_DEV}" = "ja" ] ; then
  nkf -e < m17n-lib.idx > temp.idx; mv temp.idx m17n-lib.idx
fi
makeindex m17n-lib.idx
${LATEX} m17n-lib.tex
