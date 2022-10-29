#
# Clawsker po Makefile
# Copyright 2007-2022 Ricardo Mones <ricardo@mones.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# See COPYING file for license details.
#

NAME = clawsker
TITLE = \# Translatable strings for Clawsker
COPYR = \# Copyright (C) 2007 Ricardo Mones <ricardo@mones.org>
VERSION ?= $(shell git describe)
PREFIX ?= /usr/local
DATADIR = ${PREFIX}/share
LOCALEDIR = ${DATADIR}/locale

XG_ARGS = --keyword=_ --flag=_:1:pass-java-format -L Perl -w 80 --package-name=${NAME} --package-version=${VERSION} --msgid-bugs-address=ricardo@mones.org --from-code=UTF-8
LINGUAS = es fr nl pt_BR sv nb de ca tr da zh_TW pt_PT pl

all: build

${NAME}.pot.0:
	xgettext ${XG_ARGS} -f ./POTFILES -d ${NAME} -o $@

# remove bogus entry about_title
${NAME}.pot.1: ${NAME}.pot.0
	head -17 $< > $@
	tail -$(shell expr $(shell wc -l < $<) - 22 ) $< >> $@
	rm -f $<

update-pot: ${NAME}.pot.1
	sed 's,^# SOME DESC.*,${TITLE},;s,^# Copyright.*,${COPYR},' < $< > ${NAME}.pot
	rm -f $<

%.pox: %.po
	msgmerge -o $@ --previous $< ${NAME}.pot 

build:
	for po in ${LINGUAS}; \
	do msgfmt -v --statistics -c -o t-$${po} $${po}.po && mv -f t-$${po} $${po}.mo; \
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

