#!/bin/sh

cat <<EOF
/***en @page m17nDBData Data provided by the m17n database

The m17n database provides the following data. */

/***ja @page m17nDBMIM M17N �ǡ����١������󶡤���ǡ���

M17N �ǡ����١����ϰʲ��Υǡ������󶡤��롣 */

/***
<ul>
<li> @ref mim-list
<li> @ref flt-list
</ul>
*/

/***en @section mim-list Input method

List of input methods provided by the m17n databasse and their brief
descriptions.  */

/***ja @section mim-list ���ϥ᥽�å�

M17N �ǡ����١������󶡤������ϥ᥽�åɤΥꥹ�ȤȤ��줾��δ�ñ�������� */

/***
<ul>
EOF

for file in $1/*.mim; do
  sed -n '/^;; <li>/,/^$/ s/^;; *//p' < $file
  echo
done

cat <<EOF
</ul>
*/

/***en @section flt-list Font Layout Table

List of Font Layout Tables (FLTs) provided by the m17n databasse and
their brief descriptions.  */

/***ja @section flt-list �ե���ȡ��쥤�����ȡ��ơ��֥�

M17N �ǡ����١������󶡤���ե���ȡ��쥤�����ȡ��ơ��֥� (FLT) �Υꥹ
�ȤȤ��줾��δ�ñ�������� */

/***
<ul>
EOF

for file in $1/*.flt; do
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
