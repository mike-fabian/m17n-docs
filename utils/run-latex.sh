#!/bin/sh
# $1: source directory
# $2: ja or usr or dev

umask 002
TEXINPUTS=$1/styles:$1/data-$2:.:
export TEXINPUTS
echo ${TEXINPUTS}
cd $2/latex
if [ "$2" = "ja" ] ; then
  LATEX=platex
  PAPER='-t a4'
else
  LATEX=platex
fi
${LATEX} m17nlib.tex
if [ "$2" = "ja" ] ; then
  nkf -e < m17nlib.idx > temp.idx; mv temp.idx refman.idx
fi
makeindex m17nlib.idx
${LATEX} m17nlib.tex
dvips ${PAPER} -o m17nlib.ps m17nlib.dvi
