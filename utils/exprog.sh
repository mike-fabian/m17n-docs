#!/bin/sh

cat <<EOF
/***en @page m17nExProg Example Programs

This section describes these example programs.  They are to demonstrate
the usage of the m17n library, not for practical use.

<ul>
EOF

cat $* | grep '@page' | sed -e 's/@page \([^ ]*\)/<li> @ref \1 "\1" --/'

cat <<EOF
</ul>
*/
EOF

cat $* | \
sed -n -e '/\/\*\*\*/,/\*\// p' | \
sed -e 's/@section/@subsection/' \
    -e 's/@page \([^ ]*\)/@section \1 \1 --/'
