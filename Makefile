OBJECTS := `find src -type f -name "*.cpp"`
CXXFLAGS:= -std=c++17 -pthread -Wall -Wno-comment -fPIC -O2 -pipe -Wl,--wrap=main

.SILENT: all clean install uninstall lib examples test

all: lib examples

clean:
	rm -rf bin/

lib:
	echo "Compiling the library..."
	echo Files: $(OBJECTS)
	mkdir -p bin/
	$(CXX) $(CXXFLAGS) $(OBJECTS) -shared -o bin/libutz.so

test:
	echo "Testing the library..."
	mkdir -p bin/test
	$(CXX) $(CXXFLAGS) -x c++ examples/utz/main.tpp -o bin/test/main -lutz
	bin/test/main

examples:
	echo "Compiling examples..."

install:
	(\
		mkdir -p /usr/include/utz \
		&& cp src/*.hpp $(OBJECTS) /usr/include/utz \
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
