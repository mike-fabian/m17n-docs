#	-*- coding: euc-jp; -*-

EXTRA_DIST = dev usr ja smallmule.gif

# The followings are for maintainers only.

if MAINTAINER_MODE

SRCFILES = $(shell echo @M17NLIB@/src/*.[ch])

STYLEPATH = @abs_srcdir@/styles
UTILPATH = @abs_srcdir@/utils

LATEX_JA = ${STYLEPATH}/doxygen-m17n.sty \
	@abs_srcdir@/data-ja/header.tex \
	@abs_srcdir@/data-ja/introduction.tex \
	@abs_srcdir@/data-ja/m17n-basicC.tex \
	@abs_srcdir@/data-ja/m17n-X.tex \
	@abs_srcdir@/data-ja/m17n-database.tex \
	@abs_srcdir@/data-ja/conclusion.tex

LATEX_USR = ${STYLEPATH}/doxygen-m17n.sty \
	@abs_srcdir@/data-usr/header.tex \
	@abs_srcdir@/data-usr/conclusion.tex

LATEX_DEV = ${STYLEPATH}/doxygen-m17n.sty \
	@abs_srcdir@/data-dev/header.tex \
	@abs_srcdir@/data-dev/conclusion.tex

DOXYGEN = doxygen

PROJECT_NAME_EN = "Multilingual Library for Unix/Linux"
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

usr-latex latex-usr: usr/latex/refman.ps
ja-latex latex-ja: ja/latex/refman.ps
dev-latex latex-dev: dev/latex/refman.ps

usr-man man-usr: man/man3m/m17nIntro.3m

usr: html-usr latex-usr man-usr
ja: html-ja latex-ja
dev: html-dev latex-dev

doxyfile-html.usr: doxyfile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/' \
	    -e 's/%INPUT_FILTER%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-html.dev: doxyfile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/dev/' \
	    -e 's/%INPUT_FILTER%/dev/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-html.ja: doxyfile
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

doxyfile-latex.dev: doxyfile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/dev/' \
	    -e 's/%INPUT_FILTER%/dev/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-latex.ja: doxyfile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%USR_JA_DEV%/ja/' \
	    -e 's/%INPUT_FILTER%/ja/' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	    -e 's|%GENERATE_MAN%|NO|' \
	  < $< >$@

doxyfile-man.usr: doxyfile
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%USR_JA_DEV%/usr/' \
	    -e 's/%INPUT_FILTER%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|NO|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	    -e 's|%GENERATE_MAN%|YES|' \
	  < $< >$@

%/html/index.html: doxyfile-html.% ${SRCFILES} m17nlib.css
	${DOXYGEN} $<

%/latex/refman.tex: doxyfile-latex.% ${UTILPATH}/refman-filter.awk ${SRCFILES}
	${DOXYGEN} $<; \
	awk -f ${UTILPATH}/refman-filter.awk < $@ > temp; \
	mv temp $@

ja/latex/refman.ps: ja/latex/refman.tex ${UTILPATH}/run-latex.sh ${LATEX_JA}
	${UTILPATH}/run-latex.sh @abs_srcdir@ ja
	emacs -batch -q -l ${UTILPATH}/mokuji.el -f write-mokuji ja

usr/latex/refman.ps: usr/latex/refman.tex ${UTILPATH}/run-latex.sh ${LATEX_USR}
	${UTILPATH}/run-latex.sh @abs_srcdir@ usr
	emacs -batch -q -l ${UTILPATH}/mokuji.el -f write-mokuji usr

dev/latex/refman.ps: dev/latex/refman.tex ${UTILPATH}/run-latex.sh ${LATEX_DEV}
	${UTILPATH}/run-latex.sh @abs_srcdir@ dev
	emacs -batch -q -l ${UTILPATH}/mokuji.el -f write-mokuji dev

doxyhead.txt: sample.c ${UTILPATH}/mkheaderlist.rb
	-${DOXYGEN} -g doxytemp
	echo "INPUT = sample.c" >> doxytemp
	echo "GENERATE_LATEX = NO" >> doxytemp
	echo "GENERATE_HTML = NO" >> doxytemp
	echo "GENERATE_MAN = YES" >> doxytemp
	echo "MAN_OUTPUT = sample" >> doxytemp
	echo "OPTIMIZE_OUTPUT_FOR_C  = yes" >> doxytemp
	${DOXYGEN} doxytemp
	(cd sample/man3; ruby ${UTILPATH}/mkheaderlist.rb) > $@
	rm -rf doxytemp sample

%/man/man3/m17nIntro.3m: doxyfile-man.% ${SRCFILES}
	${DOXYGEN} $<

man/man3m/m17nIntro.3m: usr/man/man3/m17nIntro.3m doxyhead.txt ${UTILPATH}/mkman.rb 
	[ -d "man/man3m" ] || mkdir -p man/man3m
	ruby ${UTILPATH}/mkman.rb usr

man/ja/man3m/m17nIntro.3m: ja/man/man3/m17nIntro.3m doxyhead.txt ${UTILPATH}/mkman.rb 
	[ -d "man/ja/man3m" ] || mkdir -p man/ja/man3m
	ruby ${UTILPATH}/mkman.rb ja

.PRECIOUS: %/latex/refman.tex

CLEANFILES = doxyfile doxyfile-*.* m17n.tag warning \
	*/html/index.html */latex/refman.*

DISTCLEANFILES = doxyfile *~

endif
