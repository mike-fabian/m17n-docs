#!/bin/sh
echo "Running aclocal..."
aclocal
echo "Running automake..."
automake -a
echo "Running autoconf..."
autoconf
echo "The remaining steps to install this packge are:"
echo "  % ./configure --enable-maintainer-mode"
echo "  % make"
echo "  % make install"
