#!/bin/sh

cat <<EOF
/***en @page m17nDBFormat Data format of the m17n database

This section describes formats of these data supplied by the m17n
database.

<ul>
EOF

cat $* | grep '@page' | sed -e 's/@page mdb\([^ ]*\)/<li> @ref mdb\1 "\1" --/'

cat <<EOF
</ul>
*/
EOF

cat $* | \
sed -n -e '/\/\*\*\*/,/\*\// p' | \
sed -e 's/@section/@subsection/' \
    -e 's/@page/@section/'
