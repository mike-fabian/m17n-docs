# Makefile.am -- Makefile for the m17n library documentation.
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
	man/man1/m17n-config.1 \
	man/man3/m17nIntro.3m17n \
	man/man5/mdbGeneral.5

pkgdatadir = $(datadir)/m17n/docs

EXTRA_DIST = usr/html usr/latex/m17n-lib.dvi usr/latex/m17n-lib.ps \
	man/man1 man/man3 man/man5

install-pkgdataDATA: $(pkgdata_DATA)
	$(mkinstalldirs) $(pkgdatadir)/html
	$(mkinstalldirs) $(mandir)/man1 $(mandir)/man3 $(mandir)/man5
	$(INSTALL_DATA) usr/latex/m17n-lib.dvi $(pkgdatadir)/m17n-lib.dvi
	$(INSTALL_DATA) usr/latex/m17n-lib.ps $(pkgdatadir)/m17n-lib.ps
	cd usr/html; \
	  for f in *.html *.png; do \
	    $(INSTALL_DATA) $$f $(pkgdatadir)/html/$$f; \
	  done
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
PROJECT_NAME_JA = "M17N ライブラリ"
PROJECT_VERSION = @PACKAGE_VERSION@

DOXYGEN = doxygen

EXAMPLE_PROGS = \
	@M17NLIB@/example/mconv.c \
	@M17NLIB@/example/mview.c \
	@M17NLIB@/example/mdate.c \
	@M17NLIB@/example/mdump.c \
	@M17NLIB@/example/medit.c \
	@M17NLIB@/example/mimx-anthy.c \
	@M17NLIB@/example/mimx-ispell.c

DBFORMAT = \
	@M17NDB@/FORMATS

MAN1 =	data/m17n-config.txt ${EXAMPLE_PROGS}

MAN3 =	@M17NLIB@/src/m17n-core.h \
	@M17NLIB@/src/m17n.h \
	@M17NLIB@/src/m17n-gui.h \
	@M17NLIB@/src/m17n-X.h \
	@M17NLIB@/src/m17n-misc.h \
	@M17NLIB@/src

MAN5 = ${DBFORMAT}

SRCALL = \
	mainpage.txt \
	${MAN3} \
	data/m17n-config.txt data/exprog.txt data/dbformat.txt \
	data/dbdata.txt fdl.txt

DBDATA = $(shell echo @M17NDB@/*.{dir,mim,flt,fst,tbl})

HTML_USR_TARGET = usr/html/index.html usr/html/parrot.png
HTML_JA_TARGET = ja/html/index.html ja/html/parrot.png
HTML_DEV_TARGET = dev/html/index.html dev/html/parrot.png
HTML_TARGET = ${HTML_USR_TARGET} ${HTML_JA_TARGET} ${HTML_DEV_TARGET}

usr-html html-usr: ${HTML_USR_TARGET}
ja-html html-ja: ${HTML_JA_TARGET}
dev-html html-dev: ${HTML_DEV_TARGET}

LATEX_USR_TARGET = usr/latex/m17n-lib.dvi usr/latex/m17n-lib.ps
LATEX_JA_TARGET = ja/latex/m17n-lib.dvi ja/latex/m17n-lib.ps
LATEX_DEV_TARGET = dev/latex/m17n-lib.dvi dev/latex/m17n-lib.ps
LATEX_TARGET = ${LATEX_USR_TARGET} ${LATEX_JA_TARGET} ${LATEX_DEV_TARGET}

usr-latex latex-usr: ${LATEX_USR_TARGET}
ja-latex latex-ja: ${LATEX_JA_TARGET}
dev-latex latex-dev: ${LATEX_DEV_TARGET}

MAN_USR_TARGET = man/man1/m17n-config.1 man/man3/m17nIntro.3m17n man/man5/mdbGeneral.5
MAN_JA_TARGET = man/ja/man1/m17n-config.1 man/ja/man3/m17nIntro.3m17n man/ja/man5/mdbGeneral.5
MAN_TARGET = ${MAN_USR_TARGET} ${MAN_JA_TARGET}

usr-man man-usr: ${MAN_USR_TARGET}
ja-man man-ja: ${MAN_JA_TARGET}

TARGET = ${HTML_TARGET} ${LATEX_TARGET} ${MAN_TARGET}

usr: usr-html usr-latex usr-man
ja: ja-html ja-latex ja-man
dev: dev-html dev-latex

html: usr-html ja-html dev-html
latex: usr-latex ja-latex dev-latex
man: usr-man ja-man

doxyfile-html: doxyfile ${SRCALL}
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRCALL}|' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	    -e 's|%ENABLED_SECTIONS%|FOR-HTML|' \
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

doxyfile-latex: doxyfile ${SRCALL}
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${SRCALL}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	    -e 's|%ENABLED_SECTIONS%|FOR-LATEX|' \
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

doxyfile-man1: doxyfile ${SRCALL}
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${MAN1}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	    -e 's|%MAN_EXTENSION%|.1|' \
	    -e 's|%ENABLED_SECTIONS%|FOR-MAN|' \
	  < $< >$@

doxyfile-man3: doxyfile ${SRCALL}
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${MAN3}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	    -e 's|%MAN_EXTENSION%|.3m17n|' \
	    -e 's|%ENABLED_SECTIONS%|FOR-MAN|' \
	  < $< >$@

doxyfile-man5: doxyfile ${SRCALL}
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%INPUT%|${MAN5}|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	    -e 's|%MAN_EXTENSION%|.5|' \
	    -e 's|%ENABLED_SECTIONS%|FOR-MAN|' \
	  < $< >$@

doxyfile-man%.usr: doxyfile-man%
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

data/exprog.txt: ${EXAMPLE_PROGS} utils/exprog.sh
	utils/exprog.sh ${EXAMPLE_PROGS} > $@

data/dbdata.txt: ${DBDATA} @M17NDB@/mdb.dir utils/dbdata.awk
	@AWK@ -f utils/dbdata.awk @M17NDB@/mdb.dir > $@

data/dbformat.txt: ${DBFORMAT} utils/dbformat.sh
	utils/dbformat.sh ${DBFORMAT}/*.txt > $@

data/m17n-config.txt: @M17NLIB@/m17n-config.in
	sed -n -e '/\/\*\*\*/,/\*\// p' < $< > $@

%/html/index.html: doxyfile-html.% header.%.html footer.%.html ${SRCALL} \
			utils/%_filter.rb m17n-lib.css
	rm -f `dirname $@`/*.html
	${DOXYGEN} $<
	echo 'code { font-weight: bold }' >> `dirname $@`/doxygen.css

%/html/parrot.png: parrot.png
	cp $< $@

%/latex/refman.tex: doxyfile-latex.% ${SRCALL} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/latex/m17n-lib.dvi: %/latex/refman.tex data-%/m17n-lib.sty utils/latex.sh
	utils/latex.sh `dirname $@` latex

%/latex/m17n-lib.ps: %/latex/m17n-lib.dvi utils/dvips.sh
	utils/dvips.sh `dirname $@` dvips
#	emacs -batch -q -l utils/mokuji.el -f write-mokuji $@

%/latex/m17n-lib.pdf: %/latex/m17n-lib.tex data-%/m17n-lib.sty utils/latex.sh
	utils/latex.sh `dirname $@` pdflatex

%/man/man1/m17n-config.1: doxyfile-man1.% ${MAN1} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/man/man3/m17nIntro.3m17n: doxyfile-man3.% ${MAN3} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/man/man5/mdbGeneral.5: doxyfile-man5.% ${MAN5} utils/%_filter.rb
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
	rm -rf doxywork man/man3/*
	ruby utils/mkman.rb 3m17n usr/man/man3 man/man3

man/man5/%: usr/man/man5/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/man5
	rm -rf doxywork man/man5/*
	ruby utils/mkman.rb 5 usr/man/man5 man/man5

man/ja/man1/%: ja/man/man1/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/ja/man1
	rm -rf doxywork man/ja/man1/*
	ruby utils/mkman.rb 1 ja/man/man1 man/ja/man1

man/ja/man3/%: ja/man/man3/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/ja/man3
	rm -rf doxywork man/ja/man3/*
	ruby utils/mkman.rb 3m17n ja/man/man3 man/ja/man3

man/ja/man5/%: ja/man/man5/% sample/man3/SampleGroup.3 utils/mkman.rb 
	$(mkinstalldirs) man/ja/man5
	rm -rf doxywork man/ja/man5/*
	ruby utils/mkman.rb 5 ja/man/man5 man/ja/man5

CLEANFILES=doxyfile-* ${TARGET} *.tar.gz warning *~

clean-local:
	rm -rf usr dev ja man doxywork

WEBDIR = /project/web/extra/m17n-lib/m17n-docs

release: dist
	[ -d ${WEBDIR} ] || mkdir ${WEBDIR}
	cd usr/html; for f in *; do \
	  case $$f in *8c*);; *8h*);; *8txt*);; *) echo $$f;; esac; \
	done
	cp ${distdir}.tar.gz ${WEBDIR}


.PRECIOUS: %/latex/refman.tex %/man/man3/m17nIntro.3m ${SRCALL}

endif

# Local Variables:
# coding: euc-jp
# End:
