#	-*- coding: euc-jp; -*-

EXTRA_DIST = dev usr ja smallmule.gif

# The followings are for maintainers only.

if MAINTAINER_MODE

SRCFILES = $(shell echo @M17NLIB@/src/*.[ch])

STYLEPATH = @srcdir@/styles
UTILPATH = @srcdir@/utils

LATEX_JA = ${STYLEPATH}/doxygen-m17n.sty \
	@srcdir@/data-ja/header.tex \
	@srcdir@/data-ja/introduction.tex \
	@srcdir@/data-ja/m17n-basicC.tex \
	@srcdir@/data-ja/m17n-X.tex \
	@srcdir@/data-ja/m17n-database.tex \
	@srcdir@/data-ja/conclusion.tex

LATEX_USR = ${STYLEPATH}/doxygen-m17n.sty \
	@srcdir@/data-usr/header.tex

LATEX_DEV = ${STYLEPATH}/doxygen-m17n.sty \
	@srcdir@/data-dev/header.tex

DOXYGEN = doxygen

PROJECT_NAME_EN = "Multilingual Library for Unix/Linux"
PROJECT_NAME_JA = "Unix/Linux 用多言語ライブラリ"

PROJECT_NUMBER = 1.0

LATEX_HEADER_JA = header.tex
LATEX_HEADER_EN =

notarget:
	@echo "Please specify one of the following targets:"
	@echo "  usr-latex ja-latex dev-latex"
	@echo "  usr-html ja-html dev-html"
	@echo "  usr ja dev"
	@echo "  all"

all: usr ja dev

usr-html html-usr: usr/html/index.html
ja-html html-ja: ja/html/index.html
dev-html html-dev: dev/html/index.html

usr-latex latex-usr: usr/latex/refman.ps
ja-latex latex-ja: ja/latex/refman.ps
dev-latex latex-dev: dev/latex/refman.ps

usr: html-usr latex-usr
ja: html-ja latex-ja
dev: html-dev latex-dev

doxyfile-html.usr: @srcdir@/doxyfile ${SRCFILES}
	umask 002; \
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%PROJECT_NUMBER%/${PROJECT_NUMBER}/' \
	    -e 's/%DEV_OR_USR_OR_JA%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	  < $< >$@

doxyfile-html.dev: @srcdir@/doxyfile ${SRCFILES}
	umask 002; \
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%PROJECT_NUMBER%/${PROJECT_NUMBER}/' \
	    -e 's/%DEV_OR_USR_OR_JA%/dev/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	  < $< >$@

doxyfile-html.ja: @srcdir@/doxyfile ${SRCFILES}
	umask 002; \
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%PROJECT_NUMBER%/${PROJECT_NUMBER}/' \
	    -e 's/%DEV_OR_USR_OR_JA%/ja/' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|NO|' \
	  < $< >$@

doxyfile-latex.usr: @srcdir@/doxyfile ${SRCFILES}
	umask 002; \
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%PROJECT_NUMBER%/${PROJECT_NUMBER}/' \
	    -e 's/%DEV_OR_USR_OR_JA%/usr/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	  < $< >$@

doxyfile-latex.dev: @srcdir@/doxyfile ${SRCFILES}
	umask 002; \
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_EN}|' \
	    -e 's/%PROJECT_NUMBER%/${PROJECT_NUMBER}/' \
	    -e 's/%DEV_OR_USR_OR_JA%/dev/' \
	    -e 's/%OUTPUT_LANGUAGE%/English/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	  < $< >$@

doxyfile-latex.ja: @srcdir@/doxyfile ${SRCFILES}
	umask 002; \
	sed -e 's|%PROJECT_NAME%|${PROJECT_NAME_JA}|' \
	    -e 's/%PROJECT_NUMBER%/${PROJECT_NUMBER}/' \
	    -e 's/%DEV_OR_USR_OR_JA%/ja/' \
	    -e 's/%OUTPUT_LANGUAGE%/Japanese/' \
	    -e 's|%GENERATE_HTML%|YES|' \
	    -e 's|%GENERATE_LATEX%|YES|' \
	  < $< >$@

%/html/index.html: doxyfile-html.%
	umask 002; \
	${DOXYGEN} $<

%/latex/refman.tex: doxyfile-latex.% ${UTILPATH}/refman-filter.awk
	umask 002; \
	${DOXYGEN} $<; \
	awk -f ${UTILPATH}/refman-filter.awk < $@ > temp; \
	mv temp $@

ja/latex/refman.ps: ja/latex/refman.tex ${UTILPATH}/run-latex.sh ${LATEX_JA}
	${UTILPATH}/run-latex.sh @srcdir@ ja
	emacs21 -batch -q -l ${UTILPATH}/mokuji.el -f write-mokuji ja

usr/latex/refman.ps: usr/latex/refman.tex ${UTILPATH}/run-latex.sh ${LATEX_USR}
	${UTILPATH}/run-latex.sh @srcdir@ usr
	emacs21 -batch -q -l ${UTILPATH}/mokuji.el -f write-mokuji usr

dev/latex/refman.ps: dev/latex/refman.tex ${UTILPATH}/run-latex.sh ${LATEX_DEV}
	${UTILPATH}/run-latex.sh @srcdir@ dev
	emacs21 -batch -q -l ${UTILPATH}/mokuji.el -f write-mokuji dev

.PRECIOUS: %/latex/refman.tex

CLEANFILES = doxyfile doxyfile-latex.* doxyfile-html.* m17n.tag warning \
	*/html/index.html */latex/refman.*

DISTCLEANFILES = doxyfile *~

endif
