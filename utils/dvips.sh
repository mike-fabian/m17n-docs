#!/bin/sh
# $1: target directory (usr/latex, ja/latex, or dev/latex)
# $2: dvips commnad (usually dvips)

umask 002
export TEXINPUTS
cd $1
DVIPS=$2
${DVIPS} -o m17n-lib.ps m17n-lib.dvi

