#	-*- coding: euc-jp; -*-

EXTRA_DIST = dev usr ja smallmule.gif

# The followings are for maintainers only.

if MAINTAINER_MODE

SRCFILES = $(shell echo @M17NLIB@/src/*.[ch])

STYLEPATH = @abs_srcdir@/styles

LATEX_JA = ${STYLEPATH}/doxygen-m17n.sty \
	@abs_srcdir@/data-ja/header.tex \
	@abs_srcdir@/data-ja/introduction.tex \
	@abs_srcdir@/data-ja/m17n-basicC.tex \
	@abs_srcdir@/data-ja/m17n-X.tex \
	@abs_srcdir@/data-ja/m17n-database.tex \
	@abs_srcdir@/data-ja/conclusion.tex

LATEX_USR = data-usr/m17n-lib.sty

LATEX_DEV = ${STYLEPATH}/doxygen-m17n.sty \
	@abs_srcdir@/data-dev/header.tex \
	@abs_srcdir@/data-dev/conclusion.tex

DOXYGEN = doxygen

PROJECT_NAME_EN = "The M17N Library"
PROJECT_NAME_JA = "Unix/Linux 用多言語ライブラリ"

notarget:
	@echo "Please specify one of the following targets:"
	@echo "  usr-latex ja-latex dev-latex"
	@echo "  usr-html ja-html dev-html"
	@echo "  usr ja dev"
	@echo "  all"

all: usr ja dev man

usr-html html-usr: usr/html/index.html
ja-html html-ja: ja/html/index.html
dev-html html-dev: dev/html/index.html

usr-latex latex-usr: usr/latex/m17n-lib.ps
ja-latex latex-ja: ja/latex/m17n-lib.ps
dev-latex latex-dev: dev/latex/m17n-lib.ps

usr-man man-usr: man/man3m/m17nIntro.3m

usr: html-usr latex-usr man-usr
ja: html-ja latex-ja
dev: html-dev latex-dev

doxyfile-html.usr: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/' \
	    -e 's/%INPUT_FILTER%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-html.dev: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/dev/' \
	    -e 's/%INPUT_FILTER%/dev/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-html.ja: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%USR_JA_DEV%/ja/' \
	    -e 's/%INPUT_FILTER%/ja/' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-latex.usr: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/' \
	    -e 's/%INPUT_FILTER%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-latex.dev: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/dev/' \
	    -e 's/%INPUT_FILTER%/dev/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-latex.ja: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%USR_JA_DEV%/ja/' \
	    -e 's/%INPUT_FILTER%/ja/' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-man.usr: doxyfile Makefile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/' \
	    -e 's/%INPUT_FILTER%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	  < $< >$@

%/html/index.html: doxyfile-html.% ${SRCFILES} data-%/mainpage.c m17n-lib.css
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/latex/refman.tex: doxyfile-latex.% ${SRCFILES} data-%/mainpage.c
	rm -rf `dirname $@`
	${DOXYGEN} $<

%/latex/m17n-lib.tex: %/latex/refman.tex utils/refman-filter.sed
	sed -f utils/refman-filter.sed < $< > $@

%/latex/m17n-lib.ps: %/latex/m17n-lib.tex data-%/m17n-lib.sty utils/latex.sh
	utils/latex.sh `dirname $@` platex
	emacs -batch -q -l utils/mokuji.el -f write-mokuji $@

%/latex/m17n-lib.pdf: %/latex/m17n-lib.tex data-%/m17n-lib.sty utils/latex.sh
	utils/latex.sh `dirname $@ `pdflatex

doxyhead.txt: sample.c utils/mkheaderlist.rb

%/man/man3/m17nIntro.3m: doxyfile-man.% ${SRCFILES}
	rm -rf `dirname $@`
	${DOXYGEN} $<

man/man3m/%.3m: usr/man/man3/%.3m sample.c utils/mkman.rb 
	-${DOXYGEN} -g doxytemp
	echo "INPUT = sample.c" >> doxytemp
	echo "GENERATE_LATEX = NO" >> doxytemp
	echo "GENERATE_HTML = NO" >> doxytemp
	echo "GENERATE_MAN = YES" >> doxytemp
	echo "MAN_OUTPUT = sample" >> doxytemp
	echo "OPTIMIZE_OUTPUT_FOR_C  = yes" >> doxytemp
	${DOXYGEN} doxytemp
	[ -d "man/man3m" ] || mkdir -p man/man3m
	ruby utils/mkman.rb usr
	rm -rf doxytemp sample

man/ja/man3m/%.3m: ja/man/man3/%.3m sample-ja.c utils/mkman.rb 
	-${DOXYGEN} -g doxytemp
	echo "INPUT = sample.c" >> doxytemp
	echo "GENERATE_LATEX = NO" >> doxytemp
	echo "GENERATE_HTML = NO" >> doxytemp
	echo "GENERATE_MAN = YES" >> doxytemp
	echo "MAN_OUTPUT = sample" >> doxytemp
	echo "OPTIMIZE_OUTPUT_FOR_C  = yes" >> doxytemp
	${DOXYGEN} doxytemp
	[ -d "man/ja/man3m" ] || mkdir -p man/ja/man3m
	ruby utils/mkman.rb ja
	rm -rf doxytemp sample

CLEANFILES = doxyfile doxyfile-*.* m17n.tag warning \
	*/html/index.html */latex/refman.*

DISTCLEANFILES = doxyfile *~

html/index.html: usr/html/index.html
	[ -d html ] || mkdir html
	cp usr/html/* html

latex/m17n-lib.ps: usr/latex/m17n-lib.ps
	[ -d latex ] || mkdir latex
	cp usr/latex/m17n-lib.dvi latex
	cp usr/latex/m17n-lib.ps latex

pack: latex/m17n-lib.ps html/index.html man/man3m/m17nIntro.3m dist

endif
DISTFILES = latex html man 
