#!/bin/sh

cat <<EOF
/***en @page m17nExample Example Programs

This section describes the example programs.  They are to demonstrate
the usage of the m17n library, not for practical use. */

EOF

sed -n -e '/\/\*\*\*/,/\*\// p' | \
sed -e 's/@section/@subsection/' \
    -e 's/@page/@section/'

cat <<EOF
////
EOF
