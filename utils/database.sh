#!/bin/sh

cat <<EOF
/***en @page m17nDBFormat Data format of the m17n database

This section describes the data formats of the m17n database. */

EOF

sed -n -e '/\/\*\*\*/,/\*\// p' | \
sed -e 's/@section/@subsection/' \
    -e 's/@page/@section/'

cat <<EOF
////
EOF
