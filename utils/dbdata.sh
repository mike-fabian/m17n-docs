#!/bin/sh

cat <<EOF
/***en @page m17nDBData Data provided by the m17n database

The m17n database provides the following data. */

/***ja @page m17nDBMIM M17N データベースが提供するデータ

M17N データベースは以下のデータを提供する。 */

/***
<ul>
<li> @ref mim-list
<li> @ref flt-list
</ul>
*/

/***en @section mim-list Input method

List of input methods provided by the m17n databasse and their brief
descriptions.  */

/***ja @section mim-list 入力メソッド

M17N データベースが提供する入力メソッドのリストとそれぞれの簡単な説明。 */

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

/***ja @section flt-list フォント・レイアウト・テーブル

M17N データベースが提供するフォント・レイアウト・テーブル (FLT) のリス
トとそれぞれの簡単な説明。 */

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
