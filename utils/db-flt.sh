#!/bin/sh

cat <<EOF
/***en @page m17nDBFLT Font Layout Tables provided by the m17n databasse

Here's a list of font layout tables provided by the m17n databasse and
their brief descriptions.  */

/***ja @page m17nDBFLT M17N データベースが提供する FLT

M17N データベースが提供する FLT (Font Layout Table) のリストとそれぞれ
の簡単な説明。 */

/*** <ul> */
EOF

for file in $*; do
  sed -n '/BEG-DOXYGEN/,/END-DOXYGEN/s/^;; //p' < $file
done

cat <<EOF
/*** </ul> */
EOF

# Local Variables:
# coding: euc-jp
# End:
