#!/bin/sh

case $1 in
*.[ch]) iconv -f EUC-JP -t UTF-8 < $1 | utils/usr_filter.rb;;
*) utils/usr_filter.rb $1;;
esac
