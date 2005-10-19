#!/bin/sh

FILE=$1
while shift 1; do
    sed -n -e "/^(input-method/s/(input-method \([^ ]*\) \([^)]*\))/<li> $FILE \1 \2/p" $FILE
    echo
    sed -n -e '/^;;;/ s/^;;; *//p' -e '/^(description "/,/^")/ s/^(description "\|^")\|\\\|$//gp' $FILE
    FILE=$1
done
