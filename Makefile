# $Header: /home/henk/CVS/dealer/Makefile,v 1.15 1999/08/05 19:57:44 henk Exp $

CC      = gcc
CFLAGS = -Wall -pedantic -O2 -I. -DNDEBUG -c
FLEX    = flex
YACC    = yacc
# Note: this should be the Berkeley Yacc, sometimes called byacc

ifeq ($(OS),Windows_NT)
	# Include ws2_32.lib, which is where ntohs and ntohl are defined
    CFLAGS += -lws2_32
endif


PROGRAM  = dealer
TARFILE  = ${PROGRAM}.tar
GZIPFILE = ${PROGRAM}.tar.gz

SRC  = dealer.c pbn.c  c4.c getopt.c pointcount.c __random.c rand.c srand.c fast_randint.c
LSRC = scan.l
YSRC = defs.y
HDR  = dealer.h tree.h fast_randint.h

OBJ  = dealer.o defs.o pbn.o c4.o getopt.o pointcount.o __random.o rand.o srand.o fast_randint.o
LOBJ = scan.c
YOBJ = defs.c


dealer: ${OBJ} ${LOBJ} ${YOBJ}
	$(CC) -o $@ ${OBJ}
	
clean:
	rm -f ${OBJ} ${LOBJ} ${YOBJ}
	${MAKE} -C Examples clean
	rm -f ${PROGRAM}

tarclean: clean ${YOBJ}
	rm -f ${TARFILE} ${GZIPFILE}

tarfile: tarclean
	# Go up a directory, delete dealer.tar, zip the dealer/ directory into
	# dealer.tar, then move that file into this directory again. Note that
	# this won't work if the current directory is not named dealer/
	cd .. ; \
		rm ${TARFILE} ; \
		tar cvf ${TARFILE} dealer ; \
		mv ${TARFILE} dealer
	# Run a new command starting in this current directory again to gzip it.
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
fast_randint.o: fast_randint.c fast_randint.h
