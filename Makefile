OBJECTS := `find src -type f -name "*.cpp"`
EXAMPLE := `find examples/src -type f -name "*.cpp"`
TESTCASE:= `find examples/utz -type f -name "*.tpp"`
MULTILINE:= sed -r 's/ /\n/g' | sed -r 's/^/\t/'
CXXFLAGS:= -std=c++17 -pthread -Wall -Wno-comment -fPIC -O2 -pipe

.SILENT: all clean install uninstall lib example test-example

all: lib examples test-example

clean:
	rm -rf bin/

lib:
	echo "Compiling the library..."
	echo "Source files:"
	echo $(OBJECTS) | $(MULTILINE)
	mkdir -p bin/
	$(CXX) $(CXXFLAGS) $(OBJECTS) -shared -o bin/libutz.so



example:
	echo "Compiling examples..."
	echo "Example source files:"
	echo $(EXAMPLE) | $(MULTILINE)
	$(CXX) $(CXXFLAGS) -shared -I./examples/src $(EXAMPLE) -o bin/libexample.so

test-example:
	echo "Compiling test cases..."
	echo "Test cases source files:"
	#echo $(TESTCASE) | $(MULTILINE)
	mkdir -p bin/test
	for testcase in $(TESTCASE); do \
		file=`basename $$testcase`;\
		file="$${file%.*}";\
		echo "~~> $$testcase ($$file)";\
		$(CXX) $(CXXFLAGS) -x c++ -Wl,--wrap=main -I./examples/src $$testcase\
			-o bin/test/$$file -L./bin/ -lutz -lexample ;\
		LD_LIBRARY_PATH=$${LD_LIBRARY_PATH}:./bin/ bin/test/$$file; \
	done

install:
	echo "We are about to install the library."
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
