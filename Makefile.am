# Makefile.am -- Makefile for the m17n library documentation.
#						 -*- coding: euc-jp; -*-
# Copyright (C) 2003
#   National Institute of Advanced Industrial Science and Technology (AIST)
#   Registration Number H15PRO112

# This file is part of the m17n library documentation, a sub-part of
# the m17n library.

# The m17n library is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2, or (at
# your option) any later version.

# The m17n library is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with the m17n library; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
# Boston, MA 02111-1307, USA.

## Process this file with Automake to create Makefile.in

pkgdata_DATA = \
	usr/html/index.html \
	usr/latex/m17n-lib.dvi usr/latex/m17n-lib.ps \
	man/man1/m17nconfig.1 \
	man/man3/m17nIntro.3m17n \
	man/man5/m17nDatabaseFormat.5

pkgdatadir = $(datadir)/m17n-lib

EXTRA_DIST = usr/html usr/latex/m17n-lib.dvi usr/latex/m17n-lib.ps \
	man/man1 man/man3 man/man5

install-pkgdataDATA: $(pkgdata_DATA)
	$(mkinstalldirs) $(pkgdatadir)/html
	$(mkinstalldirs) $(mandir)/man1 $(mandir)/man3 $(mandir)/man5
	$(INSTALL_DATA) usr/latex/m17n-lib.dvi $(pkgdatadir)/m17n-lib.dvi
	$(INSTALL_DATA) usr/latex/m17n-lib.ps $(pkgdatadir)/m17n-lib.ps
	cd usr/html; \
	  for f in *.html; do $(INSTALL_DATA) $$f $(pkgdatadir)/html/$$f; done
	cd usr/html; \
	  for f in *.png; do $(INSTALL_DATA) $$f $(pkgdatadir)/html/$$f; done
	cd man/man1; \
	  for f in *.1; do $(INSTALL_DATA) $$f $(mandir)/man1/$$f; done
	cd man/man3; \
	  for f in *.3m17n; do $(INSTALL_DATA) $$f $(mandir)/man3/$$f; done
	cd man/man5; \
	  for f in *.5; do $(INSTALL_DATA) $$f $(mandir)/man5/$$f; done

#
# The followings are for maintainers only.
#
if MAINTAINER_MODE

PROJECT_NAME_EN = "The M17N Library"
PROJECT_NAME_JA = "M17N 多言語ライブラリ"
PROJECT_VERSION = @PACKAGE_VERSION@

DOXYGEN = doxygen

SRC_MAN1 = \
	data/m17n-config.txt \
	data/mconv.txt \
	data/mview.txt \
	data/mdate.txt \
	data/mdump.txt \
	data/medit.txt

SRC_MAN3 = \
	@M17NLIB@/src/m17n-core.h \
	@M17NLIB@/src/m17n.h \
	@M17NLIB@/src/m17n-gui.h \
	@M17NLIB@/src/m17n-X.h \
	@M17NLIB@/src/m17n-err.h \
	@M17NLIB@/src

SRC_MAN5 = \
	data/dbformat.txt

SRC_ALL = \
	data/mainpage.txt ${SRC_MAN3} ${SRC_MAN1} ${SRC_MAN5}

usr-html html-usr: usr/html/index.html usr/html/parrot.png
ja-html html-ja: ja/html/index.html ja/html/parrot.png
dev-html html-dev: dev/html/index.html dev/html/parrot.png

usr-latex latex-usr: usr/latex/m17n-lib.ps
ja-latex latex-ja: ja/latex/m17n-lib.ps
dev-latex latex-dev: dev/latex/m17n-lib.ps

usr-man man-usr: man/man1/m17n-config.1 man/man3/m17nIntro.3m17n man/man5/m17nDatabaseFormat.5
ja-man man-ja: ja/man3/m17nIntro.3m

usr: html-usr latex-usr man-usr
ja: html-ja latex-ja
dev: html-dev latex-dev

doxyfile-html: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRC_ALL}|' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-html.usr: doxyfile-html
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

doxyfile-html.dev: doxyfile-html
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/dev/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

doxyfile-html.ja: doxyfile-html
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%USR_JA_DEV%/ja/g' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	  < $< >$@

doxyfile-latex: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRC_ALL}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-latex.usr: doxyfile-latex
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

doxyfile-latex.dev: doxyfile-latex
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/dev/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

doxyfile-latex.ja: doxyfile-latex
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%USR_JA_DEV%/ja/g' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	  < $< >$@

doxyfile-man1: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRC_MAN1}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	    -e 's|%MAN_EXTENSION%|.1|' \
	  < $< >$@

doxyfile-man3: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRC_MAN3}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	    -e 's|%MAN_EXTENSION%|.3m17n|' \
	  < $< >$@

doxyfile-man5: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRC_MAN5}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	    -e 's|%MAN_EXTENSION%|.5|' \
	  < $< >$@

doxyfile-man%.usr: doxyfile-man%
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

data/mainpage.txt:

data/dbformat.txt:

data/m17n-config.txt: @M17NLIB@/m17n-config.in
	sed -n -e '/BEG-DOXYGEN/,/END-DOXYGEN/ p' < $< > $@

data/%.txt: @M17NLIB@/example/%.c
	sed -n -e '/BEG-DOXYGEN/,/END-DOXYGEN/ p' < $< > $@

%/html/index.html: doxyfile-html.% ${SRC_ALL} \
			header.html footer.html \
			utils/%_filter.rb m17n-lib.css
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/html/parrot.png: parrot.png
	cp $< $@

%/latex/refman.tex: doxyfile-latex.% ${SRC_ALL} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/latex/m17n-lib.tex: %/latex/refman.tex utils/refman-filter.sed
	sed -f utils/refman-filter.sed < $< > $@

%/latex/m17n-lib.dvi: %/latex/m17n-lib.tex data-%/m17n-lib.sty utils/latex.sh
	utils/latex.sh `dirname $@` latex

%/latex/m17n-lib.ps: %/latex/m17n-lib.dvi utils/dvips.sh
	utils/dvips.sh `dirname $@` dvips
#	emacs -batch -q -l utils/mokuji.el -f write-mokuji $@

%/latex/m17n-lib.pdf: %/latex/m17n-lib.tex data-%/m17n-lib.sty utils/latex.sh
	utils/latex.sh `dirname $@` pdflatex

%/man/man1/m17n-config.1: doxyfile-man1.% ${SRC_MAN1} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/man/man3/m17nIntro.3m17n: doxyfile-man3.% ${SRC_MAN3} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/man/man5/m17nDatabaseFormat.5: doxyfile-man5.% ${SRC_MAN5} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

sample/man3/SampleGroup.3: sample.c
	[ -d sample ] || mkdir sample
	[ -d sample/man3 ] || mkdir sample/man3
	-${DOXYGEN} -g doxytemp
	echo "INPUT = sample.c" >> doxytemp
	echo "GENERATE_LATEX = NO" >> doxytemp
	echo "GENERATE_HTML = NO" >> doxytemp
	echo "GENERATE_MAN = YES" >> doxytemp
	echo "MAN_OUTPUT = sample" >> doxytemp
	echo "OPTIMIZE_OUTPUT_FOR_C  = yes" >> doxytemp
	${DOXYGEN} doxytemp
	rm -rf doxytemp

man/man1/%: usr/man/man1/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/man1
	rm -rf doxywork man/man1/*
	ruby utils/mkman.rb 1 usr/man/man1 man/man1

man/man3/%: usr/man/man3/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/man3
	rm -rf doxywork usr/man3/*
	ruby utils/mkman.rb 3m17n usr/man/man3 man/man3

man/man5/%: usr/man/man5/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/man5
	rm -rf doxywork usr/man5/*
	ruby utils/mkman.rb 5 usr/man/man5 man/man5

ja/man3m/%.3m: ja/man/man3/%.3m sample-ja.c utils/mkman.rb 
	-${DOXYGEN} -g doxytemp
	echo "INPUT = sample.c" >> doxytemp
	echo "GENERATE_LATEX = NO" >> doxytemp
	echo "GENERATE_HTML = NO" >> doxytemp
	echo "GENERATE_MAN = YES" >> doxytemp
	echo "MAN_OUTPUT = sample" >> doxytemp
	echo "OPTIMIZE_OUTPUT_FOR_C  = yes" >> doxytemp
	${DOXYGEN} doxytemp
	[ -d "ja/man3m" ] || mkdir -p ja/man3m
	rm -rf ja/man3m/index.*
	ruby utils/mkman.rb ja
	rm -rf doxytemp sample

CLEANFILES=doxyfile-* *.tar.gz warning *~

clean-local:
	rm -rf usr dev ja doxywork

WEBDIR = /project/web/extra/m17n-lib/m17n-docs

web: usr-html
	[ -d ${WEBDIR} ] || mkdir ${WEBDIR}
	[ -f ${distdir}.tar.gz ] || make dist
	cp ${distdir}.tar.gz ${WEBDIR}
	cp usr/html/* ${WEBDIR}

.PRECIOUS: %/latex/m17n-lib.tex %/man/man3/m17nIntro.3m ${SRC_ALL}

endif
