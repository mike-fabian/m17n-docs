#!/bin/sh

cat <<EOF
/***en @page m17nDBMIM Input methods provided by the m17n databasse

Here's a list of input methods provided by the m17n databasse and
their brief descriptions.  */

/***ja @page m17nDBMIM M17N �ǡ����١������󶡤������ϥ᥽�å�

M17N �ǡ����١������󶡤������ϥ᥽�åɤΥꥹ�ȤȤ��줾��δ�ñ�������� */
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
