#	-*- coding: euc-jp; -*-
# This makefile is for maintainer only.

pkgdata_DATA = \
	usr/html/index.html \
	usr/man3m/m17nIntro.3m \
	usr/latex/m17n-lib.dvi usr/latex/m17n-lib.ps


if MAINTAINER_MODE

SRCFILES = $(shell echo @M17NLIB@/src/*.[ch] @M17NLIB@/example/README.txt)

PROJECT_NAME_EN = "The M17N Library"
PROJECT_NAME_JA = "M17N 多言語ライブラリ"
PROJECT_VERSION = @PACKAGE_VERSION@

DOXYGEN = doxygen

usr-html html-usr: usr/html/index.html
ja-html html-ja: ja/html/index.html
dev-html html-dev: dev/html/index.html

usr-latex latex-usr: usr/latex/m17n-lib.ps
ja-latex latex-ja: ja/latex/m17n-lib.ps
dev-latex latex-dev: dev/latex/m17n-lib.ps

usr-man man-usr: usr/man3m/m17nIntro.3m
ja-man man-ja: ja/man3m/m17nIntro.3m

usr: html-usr latex-usr man-usr
ja: html-ja latex-ja
dev: html-dev latex-dev

doxyfile-html: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%M17NLIB%|@M17NLIB@|' \
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
	    -e 's|%M17NLIB%|@M17NLIB@|' \
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

doxyfile-man: doxyfile
	sed -e 's|%PROJECT_NUMBER%|@PACKAGE_VERSION@|' \
	    -e 's|%M17NLIB%|@M17NLIB@|' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	  < $< >$@

doxyfile-man.usr: doxyfile-man
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/g' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	  < $< >$@

%/html/index.html: doxyfile-html.% ${SRCFILES} data-%/mainpage.txt data-%/dbformat.txt \
			utils/%_filter.rb m17n-lib.css
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/latex/refman.tex: doxyfile-latex.% ${SRCFILES} data-%/mainpage.txt data-%/dbformat.txt \
			utils/%_filter.rb
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

%/man/man3/m17nIntro.3m: doxyfile-man.% ${SRCFILES} utils/%_filter.rb
	rm -rf `dirname $@`
	${DOXYGEN} $<

usr/man3m/%.3m: usr/man/man3/%.3m sample.c utils/mkman.rb 
	-${DOXYGEN} -g doxytemp
	echo "INPUT = sample.c" >> doxytemp
	echo "GENERATE_LATEX = NO" >> doxytemp
	echo "GENERATE_HTML = NO" >> doxytemp
	echo "GENERATE_MAN = YES" >> doxytemp
	echo "MAN_OUTPUT = sample" >> doxytemp
	echo "OPTIMIZE_OUTPUT_FOR_C  = yes" >> doxytemp
	${DOXYGEN} doxytemp
	[ -d usr/man3m ] || mkdir -p usr/man3m
	rm -rf usr/man3m/index.*
	ruby utils/mkman.rb usr
	rm -rf doxytemp sample

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

EXTRA_DIST = usr/html usr/man3m usr/latex/m17n-lib.dvi usr/latex/m17n-lib.ps

endif
