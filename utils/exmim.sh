#!/bin/sh

cat <<EOF
/***en @page m17nExMim Example Input Methods

This section describes these example input methods.  They are to
demonstrate the usage of the m17n library, not for practical use.

<ul>
EOF

cat $* | grep '@page' | sed -e 's/;; @page \([^.]*\).mim/<li> @ref \1 "\1.mim" --/'

cat <<EOF
</ul>
*/
EOF

cat $* | \
sed -n -e '/;; \/\*\*\*/,/;; \*\// p' | \
sed -e 's/;; *//' \
    -e 's/@section/@subsection/' \
    -e 's/@page \([^.]*\).mim/@section \1 \1.mim --/'
