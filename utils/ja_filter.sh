#!/bin/sh

case $1 in
*dbdata.txt) utils/ja_filter.rb $1;;
*) utils/ja_filter.rb $1 | iconv -f EUC-JP -t UTF-8;;
esac
