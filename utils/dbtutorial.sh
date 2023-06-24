#!/bin/sh

cat <<EOF
/* -*- coding: utf-8; -*- */
/*** @page m17nDBTutorial Tutorial for writing the m17n database

This section contains tutorials for writing various database files of
the m17n database.

<ul>
EOF

for f in $1/*-tut.txt; do
  cat $f | grep '@page' | sed -e 's/@page mdb\([^ ]*\)/<li> @ref mdb\1 "\1" --/'
done

cat <<EOF
</ul>
*/
EOF

for f in $1/*-tut.txt; do
  sed -n -e '/\/\*\*\*/,/\*\// p' < $f| \
  sed -e 's/@section/@subsection/' -e 's/@page/@section/'
done

# Local Variables:
# coding: utf-8
# End:
