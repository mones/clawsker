#
# Clawsker makefile
# $Id$
#

NAME = clawsker
VERSION = $(shell cat VERSION)
PREFIX ?= /usr/local
BINDIR = ${PREFIX}/bin
DATADIR = ${PREFIX}/share
LIBDIR = ${PREFIX}/lib/${NAME}
MANDIR = ${DATADIR}/man
MAN1DIR = ${MANDIR}/man1

all: build

build:
	mkdir build
	sed -e "s,@PREFIX@,${PREFIX},;s,@LIBDIR@,${LIBDIR},;s,@VERSION@,${VERSION}," \
		< ${NAME} > build/${NAME}
	pod2man ${NAME} > build/${NAME}.1
	

install: all install-dirs
	install -m 0755 build/${NAME} ${DESTDIR}${BINDIR}
	install -m 0644 build/${NAME}.1 ${DESTDIR}${MAN1DIR}

install-dirs:
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${MAN1DIR}

uninstall:
	rm -f ${DESTDIR}${BINDIR}/${NAME}
	rm -f ${DESTDIR}${MAN1DIR}/${NAME}.1

clean-build:
	rm -rf build

clean:
	rm -f ${NAME}.1 *~

.PHONY: all build install install-dirs uninstall clean clean-build

