#!/bin/sh

if [ $# -eq 0 ]; then exit 1; fi

# Directories for source code and output for the build.
SOURCE=src
OUTPUT=out

get_object(){
	echo "$*" | sed -Ee "s#$SOURCE/(.+).cpp#$OUTPUT/\1.o#g"
}

get_source(){
	echo "$*" | sed -Ee "s#$OUTPUT/(.+).o#$SOURCE/\1.cpp#g"
}

# Source files, objects and compiler flags
SOURCES=$(find $SOURCE/ -type f -name '*.cpp')
OBJECTS=$(get_object "$SOURCES")
CXX="clang++ -std=c++17 -stdlib=libc++"
CXXFLAGS="-Wall -Wno-comment -fPIC -O2 -pipe -I${SOURCE}/"

target="$1"
case "$target" in
.configuration:*)
	echo "Making configuration..."
	echo $OBJECTS
	make OBJECTS="`echo $OBJECTS`" ${target#.configuration:}
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
*) exit 1 ;;
esac
