#!/bin/sh

# Reform all man pages to suppress "hyphen-used-as-minus-sign"
# warnings of lintian by converting all unescaped "-" to "\-".

while [ $# -ge 1 ] ; do
    sed -e '/^[^.]/s/--/\\-\\-/g'\
	-e '/^[^.]/ s/\([^\\]\)-/\1\\-/g'\
	-e '/^-/ s/^-/\\-/g' < $1 > temp.man
    mv temp.man $1
    shift
done
