#!/bin/sh

case $1 in
*.[ch]) iconv -f EUC-JP -t UTF-8 < $1 | utils/ja_filter.rb;;
*.txt) iconv -f EUC-JP -t UTF-8 < $1 | utils/ja_filter.rb;;
*) utils/ja_filter.rb $1;;
esac
