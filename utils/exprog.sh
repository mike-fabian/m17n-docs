#!/bin/sh

cat <<EOF
/***en @page m17nExProg Sample Programs

This section describes these example programs.  They are to demonstrate
the usage of the m17n library, not for practical use.

<ul>
EOF

cat $* | grep '@enpage' | sed -e 's/@enpage \([^ ]*\)/<li> @ref \1 "\1" --/'

cat <<EOF
</ul>
*/
EOF

cat <<EOF
/***ja @page m17nExProg ����ץ�ץ����

���Υ��������ϰʲ��Υץ����ˤĤ��Ʋ��⤹�롣�����Υץ�����
m17n �饤�֥��λ���ˡ�򼨤�����Τ�ΤǤ��ꡢ�ºݤλ��ѤˤϤ��ޤ�Ŭ��
�ʤ���

<ul>
EOF

cat $* | grep '@japage' | sed -e 's/@japage \([^ ]*\)/<li> @ref \1 "\1" --/'

cat <<EOF
</ul>
*/
EOF

cat $* | \
sed -n -e '/\/\*\*\*/,/\*\// p' | \
sed -e 's/@section/@subsection/' \
    -e 's/@..page \([^ ]*\)/@section \1 \1 --/'

# Local Variables:
# coding: euc-jp
# End:
