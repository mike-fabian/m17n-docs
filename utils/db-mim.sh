#!/bin/sh

cat <<EOF
/***en @page m17nDBMIM Input methods provided by the m17n databasse

Here's a list of input methods provided by the m17n databasse and
their brief descriptions.  */

/***ja @page m17nDBMIM M17N データベースが提供する入力メソッド

M17N データベースが提供する入力メソッドのリストとそれぞれの簡単な説明。 */
/*** <ul> */
EOF

for file in $*; do
  sed -n '/^;; \/\*\*\*/,/^;; \*\//s/^;; *//p' < $file
done

cat <<EOF
/*** </ul> */
EOF

# Local Variables:
# coding: euc-jp
# End:
