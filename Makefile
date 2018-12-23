#
# Clawsker Makefile
# Copyright 2007-2018 Ricardo Mones <ricardo@mones.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# See COPYING file for license details.
#

NAME = clawsker
VERSION ?= 1.3.0
PREFIX ?= /usr/local
BINDIR = ${PREFIX}/bin
DATADIR = ${PREFIX}/share
LIBDIR = ${PREFIX}/lib/${NAME}
MANDIR = ${DATADIR}/man
MAN1DIR = ${MANDIR}/man1
APPSDIR = ${DATADIR}/applications
THEMEDIR = ${DATADIR}/icons/hicolor
ICONRES = 48 64 128

all: build

build: ${NAME}.1
	-mkdir build
	sed -e "s,@PREFIX@,${PREFIX},;s,@LIBDIR@,${LIBDIR},;s,@VERSION@,${VERSION},;s,@DATADIR@,${DATADIR}," < ${NAME} > build/${NAME}
	cp -p $< build/$<
	${MAKE} -C po build

${NAME}.1: ${NAME}.pod
	pod2man --release ${VERSION} -c '' $< > $@

install: all install-dirs install-icons
	install -m 0755 build/${NAME} ${DESTDIR}${BINDIR}
	install -m 0644 build/${NAME}.1 ${DESTDIR}${MAN1DIR}
	install -m 0644 ${NAME}.desktop ${DESTDIR}${APPSDIR}
	${MAKE} -C po install

install-dirs: install-icons-dirs
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${MAN1DIR}
	install -d ${DESTDIR}${APPSDIR}
	${MAKE} -C po install-dirs

install-icons-dirs:
	install -d ${DESTDIR}${THEMEDIR}
	for res in ${ICONRES}; do \
		install -d ${DESTDIR}${THEMEDIR}/$${res}x$${res}/apps; \
	done

install-icons: install-icons-dirs
	for res in ${ICONRES}; do \
		install -m 0644 icons/${NAME}-$${res}.png ${DESTDIR}${THEMEDIR}/$${res}x$${res}/apps/${NAME}.png; \
	done

uninstall-icons:
	for res in ${ICONRES}; do \
		rm -f ${DESTDIR}${THEMEDIR}/$${res}x$${res}/apps/${NAME}.png; \
	done

uninstall: uninstall-icons
	rm -f ${DESTDIR}${BINDIR}/${NAME}
	rm -f ${DESTDIR}${MAN1DIR}/${NAME}.1
	rm -f ${DESTDIR}${APPSDIR}/${NAME}.desktop
	${MAKE} -C po uninstall

dist:
	rm -rf ${NAME}-${VERSION}
	mkdir ${NAME}-${VERSION}
	cp -p AUTHORS ChangeLog.old ${NAME} ${NAME}.pod ${NAME}.desktop \
		COPYING Makefile NEWS README ${NAME}-${VERSION}
	mkdir ${NAME}-${VERSION}/po
	cp -p po/*.po po/*.pot po/Makefile po/POTFILES po/README po/STATUS \
		${NAME}-${VERSION}/po
	mkdir ${NAME}-${VERSION}/po/unmaint
	cp -p po/unmaint/*.po ${NAME}-${VERSION}/po/unmaint
	mkdir ${NAME}-${VERSION}/icons
	cp -p icons/*.xcf icons/*.png ${NAME}-${VERSION}/icons
	tar cJf ${NAME}-${VERSION}.tar.xz ${NAME}-${VERSION} \
		&& rm -rf ${NAME}-${VERSION}

clean-build:
	rm -f ${NAME}.1
	rm -rf build

clean: clean-build
	rm -f *~
	${MAKE} -C po clean

test-setup:
	@test -h t/Clawsker.pm || ( cd t/ && ln -s ../clawsker Clawsker.pm )

test: test-setup
	@env DISPLAY= prove -It

.PHONY: all build install install-dirs install-icons-dirs install-icons
.PHONY: uninstall uninstall-icons clean clean-build dist
.PHONY: test-setup test
