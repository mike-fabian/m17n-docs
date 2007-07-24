#!/bin/sh
echo "Running aclocal..."
aclocal
echo "Running automake..."
automake -a
echo "Running autoconf..."
autoconf
echo "The remaining steps to install this packge are:"
echo "  % ./configure"
echo "  % make"
echo "  % make install"
echo "If you are going to maintain it, call ./configure with the arg:"
echo "  --enable-maintainer-mode"
