#
# Clawsker Makefile
# Copyright 2007-2015 Ricardo Mones <ricardo@mones.org>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# See COPYING file for license details.
#

NAME = clawsker
VERSION ?= 0.7.13
PREFIX ?= /usr/local
BINDIR = ${PREFIX}/bin
DATADIR = ${PREFIX}/share
LIBDIR = ${PREFIX}/lib/${NAME}
MANDIR = ${DATADIR}/man
MAN1DIR = ${MANDIR}/man1
THEMEDIR = ${DATADIR}/icons/hicolor
ICONRES = 64 128

all: build

build:
	-mkdir build
	sed -e "s,@PREFIX@,${PREFIX},;s,@LIBDIR@,${LIBDIR},;s,@VERSION@,${VERSION},;s,@DATADIR@,${DATADIR}," < ${NAME} > build/${NAME}
	pod2man --release ${VERSION} -c '' ${NAME}.pod > build/${NAME}.1
	${MAKE} -C po build
	

install: all install-dirs install-icons
	install -m 0755 build/${NAME} ${DESTDIR}${BINDIR}
	install -m 0644 build/${NAME}.1 ${DESTDIR}${MAN1DIR}
	${MAKE} -C po install

install-dirs: install-icons-dirs
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${MAN1DIR}
	${MAKE} -C po install-dirs

install-icons-dirs:
	install -d ${DESTDIR}${THEMEDIR}
	for res in ${ICONRES}; do \
		install -d ${DESTDIR}${THEMEDIR}/$${res}x$${res}/apps; \
	done

install-icons:
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
	${MAKE} -C po uninstall

dist:
	rm -rf ${NAME}-${VERSION}
	mkdir ${NAME}-${VERSION}
	cp -p AUTHORS ChangeLog.old clawsker clawsker.pod \
		COPYING Makefile NEWS README ${NAME}-${VERSION}
	cp -rp po ${NAME}-${VERSION}
	cp -rp icons ${NAME}-${VERSION}
	tar cJf ${NAME}-${VERSION}.tar.xz ${NAME}-${VERSION} \
		&& rm -rf ${NAME}-${VERSION}

clean-build:
	rm -rf build

clean: clean-build
	rm -f *~
	${MAKE} -C po clean

.PHONY: all build install install-dirs uninstall clean clean-build dist

