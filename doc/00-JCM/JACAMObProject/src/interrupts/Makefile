
#JAVA_HOME = /usr/lib/jvm/java-25-openjdk-amd64

JAVA_HOME := $(shell java -XshowSettings:properties -version 2>&1 \
              | awk '/java.home =/ {print $$3}')

CC = gcc
CCX = g++

HEADERS_JNI = -I$(JAVA_HOME)/include -I$(JAVA_HOME)/include/linux

CXXFLAGS = -I. $(HEADERS_JNI)

LIBJASONINT_SRC = libmyjni.c
LIBJASONINT_HEADERS = libjasonint.h

.PHONY: all clean distclean

all: libmyjni.so

#run: all
#	LD_LIBRARY_PATH=. java PingPong

libjasonint.h: $(shell ls jason*.h)
	./generate_libjasonint_h.sh
	
libmyjni.so: $(LIBJASONINT_SRC) $(LIBJASONINT_HEADERS)
	$(CCX) -shared -fPIC $(CXXFLAGS) $(LIBJASONINT_SRC) -o $@

#PingPong: PingPong.java
#	javac -h . PingPong.java

clean:
	rm -f *.so *.o *.class

distclean: clean
	rm -f libjasonint.h
