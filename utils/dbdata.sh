#!/bin/sh

cd $1
set `ls $2`
FILE=$1
while shift 1; do
    sed -n -e '/^(input-method/s/(input-method \([^ ]*\) \([^ )]*\)\( \([^)]*\)\))/\1 \2 \4/p' $FILE | (read LANG NAME EXTRA
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
	fi
    )
    echo
    sed -n -e '/^;;;/ p' -e '/^(description "/,/^")/ s/^(description "\|^")\|\\\|$//gp' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//'
    FILE=$1
done
