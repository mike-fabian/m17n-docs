#!/bin/sh
# $1: target directory (usr/latex, ja/latex, or dev/latex)
# $2: dvips commnad (usually dvips)

umask 002
USR_JA_DEV=`dirname $1`
if [ $USR_JA_DEV = "ja" ] ; then
  SOURCE=m17n-lib-ja
elif [ $USR_JA_DEV = "dev" ] ; then
  SOURCE=m17n-lib-dev
else
  SOURCE=m17n-lib
fi
export TEXINPUTS
cd $1
DVIPS=$2
${DVIPS} -o ${SOURCE}.ps ${SOURCE}.dvi

