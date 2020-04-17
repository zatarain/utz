SOURCES := `find src -type f -name "*.cpp"`
MULTILINE:= sed -r 's/ /\n/g' | sed -r 's/^/\t/'
CXXFLAGS:= -std=c++17 -Wall -Wno-comment -fPIC -O2 -pipe

.SILENT: all clean install uninstall lib example test-example

all: lib example test-example

clean:
	rm -rf bin/

lib:
	echo "Compiling the library..."
	echo "Source files:"
	echo ${SOURCES} | ${MULTILINE}
	mkdir -p bin/
	${CXX} ${CXXFLAGS} ${SOURCES} -shared -o bin/libutz.so

example:
	#make --directory=application-under-test/ application
	make --directory=application-under-test/ --file=Testfile application-under-test

test-example: example
	make --directory=application-under-test/ --file=Testfile test

install:
	echo "We are about to install the library."
	(\
		mkdir -p /usr/include/utz \
		&& cp src/*.hpp ${SOURCES} /usr/include/utz \
		&& cp bin/libutz.so /usr/local/lib/ \
		&& mv /usr/include/utz/utz.hpp /usr/include/utz.hpp \
	)  || (echo "Error installing the library!" && exit 1)
	echo "The library was successfully installed!"

uninstall:
	echo "Uninstalling the library..."
	(\
		rm -rf \
			/usr/local/lib/libutz.so \
			/usr/include/utz \
	) || (echo "Error removing the library!" && exit 1)
	echo "The library was successfully uninstalled!"
