#!/bin/sh

if [ $# -eq 0 ]; then exit 1; fi
target="$1"

SOURCE=src
CXX="clang++ -std=c++17 -stdlib=libc++"
OUTPUT=out

get_object(){
	echo "$*" | sed -Ee "s#$SOURCE/(.+).cpp#$OUTPUT/\1.o#g"
}

get_source(){
	echo "$*" | sed -Ee "s#$OUTPUT/(.+).o#$SOURCE/\1.cpp#g"
}

# Variables specific for the library
SOURCES=$(find $SOURCE/ -type f -name '*.cpp')
OBJECTS=$(get_object "$SOURCES")
CXXFLAGS="-Wall -Wno-comment -fPIC -O2 -pipe -I${SOURCE}/"

case $target in
:config:*)
	make OBJECTS="$OBJECTS" ${target#:config:}
;;
out/*.o)
	make ${target%/*.o}/
	source=$(get_source "$target")
	echo "Compiling $source -> $target"
	compile="${CXX} ${CXXFLAGS} -c -o $target $source"
	echo "$compile" && $compile
;;
out/*/)
	mkdir -p $target
;;
esac

