#!/bin/sh

[ -d tmp ] || mkdir tmp

case $1 in
*) LC_ALL=ja_JP.UTF-8 utils/usr_filter.rb $1;;
esac
