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
<li> @ref charprop-list
<li> @ref misc-list
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

/***en @section charprop-list Character Property

List of character properties provided by the m17n databasse and their
brief descriptions.  */

/***ja @section charprop-list ʸ���ץ�ѥƥ�

M17N �ǡ����١������󶡤���ʸ���ץ�ѥƥ��Υꥹ�ȤȤ��줾��δ�ñ�������� */

/***
<ul>
EOF

for file in $1/*.tab; do
  sed -n '/^# <li>/,/^$/ s/^# *//p' < $file
  echo
done

cat <<EOF
</ul>
*/

/***en @section misc-list The other data

List of the other data provided by the m17n databasse and their brief
descriptions.  */

/***ja @section misc-list ����¾�Υǡ���

M17N �ǡ����١������󶡤��뤽��¾�Υǡ����Ȥ��줾��δ�ñ�������� */

/***
<ul>
EOF

for file in $1/*.tbl; do
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



