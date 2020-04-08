OBJECTS := src/mock.cpp src/assertion.cpp src/predicate.cpp
#PROJECTS:= `find * -name "main.cpp" | sed -r 's/\/[^\/]+$$//'`
CXXFLAGS:= -std=c++2a -pthread -Wall -Wno-comment -fPIC -O2 -pipe
#LIBS	:=
#-lboost_system

.SILENT: all clean install uninstall lib examples

all: lib examples
#	for project in $(PROJECTS); do make ~$$project; done

#obj/%.o: %.cpp
#	@echo "Compiling dependency: '$<'..."
#	@mkdir -p $(@D)
#	@$(CXX) -c $(CXXFLAGS) -I. $< -o $@ $(LIBS)

#~%: %
#	@echo "Building dependencies for '$<'..."
#	@for object in $(OBJECTS) `find $</*.cpp | sed -r 's/cpp$$/o/' | sed -r 's/^/obj\//'`; do make --silent $$object; done
#	@echo "Construyendo ejecutable de '$<'..."
#	@$(CXX) $(CXXFLAGS) $(OBJECTS) `find obj/$</*.o` -o bin/$< $(LIBS)

clean:
	rm -rf bin/

lib:
	echo "Compiling the library..."
	echo Files: $(OBJECTS)
	mkdir -p bin/
	$(CXX) $(CXXFLAGS) $(OBJECTS) -shared -o bin/libutz.so

test:
	echo "Testing the library..."
	$(CXX) $(CXXFLAGS) src/test.cpp -o bin/test -lutz
	bin/test

examples:
	echo "Compiling examples..."

install:
	cp bin/libutz.so /usr/local/lib/ || (echo "Error installing the library!" && exit 1)
	echo "The library was successfully installed!"

uninstall:
	echo "Uninstalling the library..."
	rm -f /usr/local/lib/libutz.so || (echo "Error removing the library!" && exit 1)
	echo "The library was successfully uninstalled!"
