#!/bin/sh

cat <<EOF
/* -*- coding: utf-8; -*- */
/***en @page m17nDBFormat Data format of the m17n database

This section describes formats of these data supplied by the m17n
database.

<ul>
EOF

for f in $1/*.txt; do
  case $f in
  *.ja.txt) ;;
  *-tut.txt) ;;
  *) cat $f | grep '@page' | sed -e 's/@page mdb\([^ ]*\)/<li> @ref mdb\1 "\1" --/';;
  esac
done

cat <<EOF
</ul>
*/
EOF

cat <<EOF
/***ja @page m17nDBFormat M17N データベースのデータ・フォーマット

ここでは、M17N データベースで提供される各データのフォーマットを解説す
る。

<ul>
EOF

for f in $1/*.txt; do
  case $f in
  *-tut.txt) ;;
  *.ja.txt) cat $f | grep '@page' | sed -e 's/@page mdb\([^ ]*\)/<li> @ref mdb\1 "\1" --/';;
  *) ;;
  esac
done

cat <<EOF
</ul>
*/
EOF


for f in $1/*.txt; do
  case $f in
  *-tut.txt) ;;
  *) cat $f | \
sed -n -e '/\/\*\*\*/,/\*\// p' | \
sed -e 's/@section/@subsection/' \
    -e 's/@page/@section/';;
  esac
done

# Local Variables:
# coding: utf-8
# End:
