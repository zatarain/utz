SOURCES := `find src/ -type f -name "*.cpp"`
MULTILINE:= sed -r 's/ /\n/g' | sed -r 's/^/\t/'
CXXFLAGS:= -std=c++17 -Wall -Wno-comment -fPIC -O2 -pipe

.SILENT: all application

all: application

application:
	echo "Compiling application-under-test..."
	echo "Source files:"
	echo ${SOURCES} | ${MULTILINE}
	mkdir -p bin
	${CXX} ${CXXFLAGS} -Isrc/ ${SOURCES} -o bin/application
