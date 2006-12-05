#!/bin/sh

IMDOC=`pwd`/utils/imdoc

set `ls $1/$2`
FILE=$1
while shift 1; do
    IM=`grep '^(input-method' $FILE`
    if test -n "$IM"; then
	if false; then
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
		base=`basename $FILE`
		dir=`dirname $FILE`
		icon="$dir/icons/$base"
		if [ -f "$icon" ] ; then
		    [ -f "images/icon-$base" ] || cp "$icon" "images/icon-$base"
		fi
		echo "<li> $FILE (language:$LANG name:$NAME @htmlonly"
		echo "<img src=\"icon-$base\" style=\"vertical-align:middle;\">"
		echo "@endhtmlonly"
		echo ")"
	    fi)
	if grep -q '^;;;' $FILE; then
	    echo
            sed -n -e '/^;;;/ p' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//' | sed -e 's,^||,<tr><td align="center">,' -e 's,||$,</td></tr>,' -e 's,|,</td><td align="center">,g'
	else
	    M17NDIR=/usr/share/m17n $IMDOC $FILE "$IM"
	fi
	else
	    M17NDIR=/usr/share/m17n $IMDOC $FILE
	fi
    else
	echo
	sed -n -e '/^;;;/ p' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//'
    fi
    FILE=$1
done
