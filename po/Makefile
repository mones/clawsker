#
# Clawsker po makefile
# $Id$
#

NAME = clawsker
VERSION = $(shell cat ../VERSION)
PREFIX ?= /usr/local
DATADIR = ${PREFIX}/share
LOCALEDIR = ${DATADIR}/locale

XG_ARGS = --keyword=_ --flag=_:1:pass-java-format -L Perl -w 80 --package-name=${NAME} --package-version=${VERSION} --msgid-bugs-address=ricardo@mones.org
LINGUAS = es sr sr@latin fr

all: build

update-pot:
	xgettext ${XG_ARGS} -f ./POTFILES -d ${NAME} -o ./${NAME}.pot

%.pox: %.po
	msgmerge -o $@ --previous $< ${NAME}.pot 

build:
	for po in ${LINGUAS}; \
	do msgfmt -c -o t-$${po} $${po}.po && mv -f t-$${po} $${po}.mo; \
	done
	

install: all install-dirs
	for po in ${LINGUAS}; \
	do install -m 0644 $${po}.mo ${DESTDIR}${LOCALEDIR}/$${po}/LC_MESSAGES/${NAME}.mo; \
	done

install-dirs:
	for po in ${LINGUAS}; \
	do install -d ${DESTDIR}${LOCALEDIR}/$${po}/LC_MESSAGES; \
	done

uninstall:
	for po in ${LINGUAS}; \
	do rm -f  ${DESTDIR}${LOCALEDIR}/$${po}/LC_MESSAGES/${NAME}.mo; \
	done

clean-build:
	rm -f *.mo

clean-pox:
	rm -f *.pox

clean: clean-build
	rm -f *~

.PHONY: all build install install-dirs uninstall clean clean-pox clean-build update-pot

