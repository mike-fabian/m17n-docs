#!/bin/sh
# $1: target directory (usr/latex, ja/latex, or dev/latex)
# $2: dvips commnad (usually dvips)

umask 002
USR_JA_DEV=`dirname $1`
export TEXINPUTS
cd $1
DVIPS=$2
${DVIPS} m17n-lib.dvi

