#!/bin/sh

IMDOC=`pwd`/utils/imdoc

cd $1
set `ls $2`
FILE=$1
while shift 1; do
    IM=`grep '^(input-method' $FILE`
    if test -n "$IM"; then
	sed -n -e '/^(input-method/s/(input-method \([^ ]*\) \([^ )]*\)\( \([^)]*\)\)*)/\1 \2 \4/p' $FILE | (read LANG NAME EXTRA
	    if test -z "NAME"; then
		NAME=$EXTRA
	    fi
	    if test "$LANG" = "t"; then
		LANG=generic
	    fi
	    if test "$NAME" = "nil"; then
		echo "<li> $FILE (extra-name:$EXTRA, only for inclusion)"
	    else
		echo "<li> $FILE (language:$LANG name:$NAME)"
	    fi)
	if grep -q '^;;;' $FILE; then
            sed -n -e '/^;;;/ p' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//' | sed -e 's,^||,<tr><td align="center">,' -e 's,||$,</td></tr>,' -e 's,|,</td><td align="center">,g'
	else
	    $IMDOC $FILE "$IM"
	fi
    else
	echo
	sed -n -e '/^;;;/ p' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//'
    fi
    FILE=$1
done
