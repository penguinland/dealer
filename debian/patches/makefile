--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # $Header: /home/henk/CVS/dealer/Makefile,v 1.15 1999/08/05 19:57:44 henk Exp $
 
 CC      = gcc
-CFLAGS = -Wall -pedantic -O2 -I. -DNDEBUG -c
+CFLAGS = -Wall -pedantic -O2 -I. -DNDEBUG -c $(shell dpkg-buildflags --get CFLAGS) $(shell dpkg-buildflags --get CPPFLAGS)
 FLEX    = flex
 YACC    = yacc
 
@@ -17,14 +17,15 @@
 OBJ  = dealer.o defs.o pbn.o c4.o getopt.o pointcount.o
 LOBJ = scan.c
 YOBJ = defs.c
+MAN  = dealer.6 dealer.dpp.6
 
 
-dealer: ${OBJ} ${LOBJ} ${YOBJ}
+dealer: ${OBJ} ${LOBJ} ${YOBJ} ${MAN}
 	${MAKE} -C Random lib
-	$(CC) -o $@ ${OBJ} -L./Random -lgnurand
+	$(CC) -o $@ ${OBJ} -L./Random -lgnurand $(shell dpkg-buildflags --get LDFLAGS)
 
 clean:
-	rm -f ${OBJ} ${LOBJ} ${YOBJ} 
+	rm -f ${OBJ} ${LOBJ} ${YOBJ} ${MAN} dealer
 	${MAKE} -C Examples clean
 	${MAKE} -C Random   clean
 
@@ -60,6 +61,12 @@
 .c.o:
 	${CC} ${CFLAGS} -o $@ $<
 
+#
+# Manpages
+#
+%.6: %.pod
+	pod2man --section=6 --release="Dealer" --center="User Documentation" $< > $@
+
 # 
 # File dependencies
 #
--- a/Examples/Makefile
+++ b/Examples/Makefile
@@ -12,11 +12,11 @@
 test: examples distribution 
 
 distribution:
-	../dealer -s 1 <Test.distribution | convert.pl >Output.distribution	
+	../dealer -s 1 <Test.distribution | ./convert.pl >Output.distribution	
 	diff Output.distribution Refer.distribution
 
 examples:
-	test_dealer.pl
+	./test_dealer.pl
 
 refer:
 	-for f in ${OUTPUT}; do \
--- a/Random/Makefile
+++ b/Random/Makefile
@@ -1,7 +1,7 @@
 SRC      = $(wildcard *.c) 
 OBJ      = $(subst .c,.o,$(wildcard *.c)) 
 GCC      = gcc
-GCCFLAGS = -c -Wall -O2 -I.
+GCCFLAGS = -c -Wall -O2 -I. $(shell dpkg-buildflags --get CFLAGS)
 HDR      = ansidecl.h
 LIB      = libgnurand.a
 AR       = ar
