#!/bin/sh

cat <<EOF
/***en @page m17nDBFLT Font Layout Tables provided by the m17n databasse

Here's a list of font layout tables (FLT) provided by the m17n
databasse and their brief descriptions.  */

/***ja @page m17nDBFLT M17N �ǡ����١������󶡤��� FLT

M17N �ǡ����١������󶡤��� Font Layout Table (FLT) �Υꥹ�ȤȤ��줾��
�δ�ñ�������� */

/***
<ul>
EOF

for file in $*; do
  sed -n '/^;; <li>/,/^$/ s/^;; *//p' < $file
  echo
done

cat <<EOF
</ul>
*/
EOF

# Local Variables:
# coding: euc-jp
# End:
