#!/bin/sh
# $1: source directory
# $2: ja or usr or dev

umask 002
CURDIR=`pwd`
TEXINPUTS=${CURDIR}/$1/styles:${CURDIR}/$1/data-$2:.:
export TEXINPUTS
cd $2/latex
if [ "$2" = "ja" ] ; then
  LATEX=platex
  PAPER='-t a4'
else
  LATEX=latex
fi
${LATEX} refman.tex
if [ "$2" = "ja" ] ; then
  nkf -e < refman.idx > temp.idx; mv temp.idx refman.idx
fi
makeindex refman.idx
${LATEX} refman.tex
dvips ${PAPER} -o refman.ps refman.dvi
