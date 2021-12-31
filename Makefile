TOP_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
SHELL = /bin/bash

HOST_DIR=${TOP_DIR}/host

GUEST_DIR=${TOP_DIR}/guest

build:	build_go_guest build_java_host

build_go_guest:
	@echo "Building Go guest..."
	cd ${GUEST_DIR} && \
	CGO_CFLAGS="-I/usr/lib/jvm/java-9-openjdk/include/ -I/usr/lib/jvm/java-9-openjdk/include/linux/" go build -o build/libhello.so -buildmode=c-shared cmd/hello.go

build_java_host:
	@echo "Building Java host..."
	cd ${HOST_DIR}/src && \
	javac `find . -name '*.java'` -d ${HOST_DIR}/build/classes

clean:
	@echo "Cleaning up..."
	rm -rf ${GUEST_DIR}/build ${HOST_DIR}/build/classes && \
	mkdir -p ${GUEST_DIR}/build ${HOST_DIR}/build/classes

run:	build
	@echo "Executing Java host..."
	LD_LIBRARY_PATH=${GUEST_DIR}/build java -cp ${HOST_DIR}/build/classes Hello
