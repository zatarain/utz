SOURCEDIR:= src
TARGETDIR:= bin
SOURCES  := $(shell find ${SOURCEDIR}/ -type f -name "*.cpp")
OBJECTS  := $(shell echo ${SOURCES} | sed --expression='s/.cpp/.o/g; s/${SOURCEDIR}\//${TARGETDIR}\//g')
CXXFLAGS := -std=c++17 -Wall -Wno-comment -fPIC -O2 -pipe -I${SOURCEDIR}/
LXXFLAGS := -shared
LIBNAME  := utz

.PHONY: all clean install uninstall test-example
.SILENT: all clean install uninstall test-example

all: ${LIBNAME}

${TARGETDIR}:
	mkdir -p $@

${TARGETDIR}/%.o: ${SOURCEDIR}/%.cpp | ${TARGETDIR}
	@mkdir -p `dirname $@`
	${CXX} ${CXXFLAGS} -c -o $@ $<

${LIBNAME}: ${OBJECTS}
	${CXX} ${CXXFLAGS} ${LXXFLAGS} $^ -o ${TARGETDIR}/lib${LIBNAME}.so

test-example: install
	make --directory=aut/ --file=Testfile test

install: ${LIBNAME}
	echo "We are about to install the library."
	(\
		cp -r ${SOURCEDIR}/${LIBNAME}.hpp ${SOURCEDIR}/${LIBNAME} /usr/include/ \
		&& cp ${TARGETDIR}/lib${LIBNAME}.so /usr/local/lib/ \
	)  || (echo "Error installing the library!" && exit 1)
	echo "The library was successfully installed!"

clean:
	rm -rf ${TARGETDIR}/

uninstall:
	echo "Uninstalling the library..."
	(\
		rm -rf \
			/usr/local/lib/lib${LIBNAME}.so \
			/usr/include/${LIBNAME}* \
	) || (echo "Error removing the library!" && exit 1)
	echo "The library was successfully uninstalled!"
