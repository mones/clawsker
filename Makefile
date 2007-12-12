#
# Clawsker makefile
# $Id$
#

NAME=clawsker
PREFIX=/usr/local
BINDIR=${PREFIX}/bin
DATADIR=${PREFIX}/share
LIBDIR=${PREFIX}/lib/${NAME}
MANDIR=${DATADIR}/man
MAN1DIR=${MANDIR}/man1

all: ${NAME}.1

${NAME}.1:
	pod2man ${NAME} > ${NAME}.1

install: all install-dirs
	install -m 0755 ${NAME} ${DESTDIR}${BINDIR}
	install -m 0644 ${NAME}.1 ${DESTDIR}${MAN1DIR}

install-dirs:
	install -d ${DESTDIR}${BINDIR}
	install -d ${DESTDIR}${MAN1DIR}

uninstall:
	rm -f ${DESTDIR}${BINDIR}/${NAME}
	rm -f ${DESTDIR}${MAN1DIR}/${NAME}.1

clean:
	rm -f ${NAME}.1 *~

.PHONY: all install install-dirs uninstall clean

