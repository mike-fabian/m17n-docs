#!/bin/sh

utils/ja_filter.rb $1 | iconv -f EUC-JP -t UTF-8
