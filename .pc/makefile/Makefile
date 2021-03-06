# $Header: /home/henk/CVS/dealer/Makefile,v 1.15 1999/08/05 19:57:44 henk Exp $

CC      = gcc
CFLAGS = -Wall -pedantic -O2 -I. -DNDEBUG -c
FLEX    = flex
YACC    = yacc

PROGRAM  = dealer
TARFILE  = ${PROGRAM}.tar
GZIPFILE = ${PROGRAM}.tar.gz

SRC  = dealer.c pbn.c  c4.c getopt.c pointcount.c
LSRC = scan.l
YSRC = defs.y
HDR  = dealer.h tree.h

OBJ  = dealer.o defs.o pbn.o c4.o getopt.o pointcount.o
LOBJ = scan.c
YOBJ = defs.c


dealer: ${OBJ} ${LOBJ} ${YOBJ}
	${MAKE} -C Random lib
	$(CC) -o $@ ${OBJ} -L./Random -lgnurand

clean:
	rm -f ${OBJ} ${LOBJ} ${YOBJ} 
	${MAKE} -C Examples clean
	${MAKE} -C Random   clean

tarclean: clean ${YOBJ}
	rm -f dealer
	rm -f ${TARFILE}  ${GZIPFILE}

tarfile: tarclean
	cd .. ; \
	tar cvf ${TARFILE} ${PROGRAM} --exclude CVS --exclude ${TARFILE}; \
	mv ${TARFILE} ${PROGRAM} 
	gzip -f ${TARFILE}

test: dealer
	${MAKE} -C Examples test

#
# Lex
#
.l.c:
	${FLEX} -t $< >$@

#
# Yacc
#
.y.c:
	${YACC} $<
	mv -f y.tab.c $@

#
# C-code
#
.c.o:
	${CC} ${CFLAGS} -o $@ $<

# 
# File dependencies
#
scan.c: scan.l
defs.c: scan.c defs.y
dealer.o: tree.h scan.l dealer.h defs.c scan.c 
pbn.o: tree.h scan.l dealer.h
defs.o:	tree.h
c4.o: c4.c  c4.h
getopt.o: getopt.h
pointcount.o: pointcount.h
