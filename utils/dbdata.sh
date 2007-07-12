#!/bin/sh

IMDOC=`pwd`/utils/imdoc

set `ls $1/$2`
FILE=$1
while shift 1; do
    IM=`grep '^(input-method' $FILE`
    if test -n "$IM"; then
	if grep -q '^;;;' $FILE; then
	    sed -n -e '/^(input-method/s/(input-method \([^ ]*\) \([^ )]*\)\( \([^)]*\)\)*)/\1 \2 \4/p' $FILE | (read LNG NAME EXTRA
	    if test -z "NAME"; then
		NAME=$EXTRA
	    fi
	    if test "$LNG" = "t"; then
		LNG=generic
	    fi
	    if test "$NAME" = "nil"; then
		HEADER="<li> $FILE (extra-name:$EXTRA, only for inclusion)"
		HEADER2=""
	    else
		title=`sed -n -e '/^(title/s/(title \("[^"]*"\).*$/\1/p' $FILE`
		file=`basename $FILE`
		base=`basename $file .mim`
		dir=`dirname $FILE`
		dir=`dirname $dir`
		icon="$dir/icons/$base.png"
		if [ -f "$icon" ] ; then
		    [ -f "images/icon-$base.png" ] || cp "$icon" "images/icon-$base.png"
		fi
		HEADER="<li> $base (language:$LNG name:$NAME @htmlonly"
		if test -n "$title"; then
		    HEADER="$HEADER title:$title"
		fi
		HEADER2="<img src=\"icon-$base.png\" style=\"vertical-align:middle;\">"
		HEADER3="@endhtmlonly"
		HEADER4=")"
	    fi
	    echo "$HEADER"
	    if test -n "$HEADER2"; then
		echo "$HEADER2"; echo "$HEADER3"; echo "$HEADER4"
	    fi
	    echo
            sed -n -e '/^;;;/ p' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//' | sed -e 's,^||,<tr><td align="center">,' -e 's,||$,</td></tr>,' -e 's,|,</td><td align="center">,g')
	else
	    M17NDIR=/usr/share/m17n $IMDOC $FILE "$IM"
	fi
    else
	echo
	sed -n -e '/^;;;/ p' $FILE | sed -e '/^[^;]/ s/$/<br>/' -e '/^;;;/ s/^;;; *//'
    fi
    FILE=$1
done
