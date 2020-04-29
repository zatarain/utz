.POSIX:
# Recomended variables/macros for installation
DESTDIR    =
PREFIX     = /usr/local
BINDIR     = ${DESTDIR}${PREFIX}/bin
LIBDIR     = ${DESTDIR}${PREFIX}/lib
INCLUDEDIR = ${DESTDIR}${PREFIX}/include
DATADIR    = ${DESTDIR}${PREFIX}/share
MANDIR     = ${DATADIR}/man
SRCDIR     = src
CXX	   = clang++ -std=c++17 -stdlib=libc++

# Macro/variables specific for the library
BUILD      = out
#SOURCES   = $(shell find ${SRCDIR}/ -type f -name "*.cpp")
#OBJECTS   = $(patsubst ${SRCDIR}%,${BUILD}%,${SOURCES:.cpp=.o})
CXXFLAGS   = -Wall -Wno-comment -fPIC -O2 -pipe -I${SRCDIR}/
LXXFLAGS   = -shared
LIBNAME    = utz

.SILENT: all clean install uninstall

.DEFAULT:
	@chmod +x Default.mk
	@./Default.mk "$@"

${BUILD}/lib${LIBNAME}.so: ${OBJECTS}
	@if [ -z "${OBJECTS}" ]; then \
		make :config:$@;\
	else \
		echo "${CXX} ${CXXFLAGS} ${LXXFLAGS} $? -o $@";\
		${CXX} ${CXXFLAGS} ${LXXFLAGS} $? -o $@;\
	fi

install: ${LIBNAME}
	echo "We are about to install the library."
	cp -r ${SRCDIR}/${LIBNAME}.hpp ${SRCDIR}/${LIBNAME} ${INCLUDEDIR}/
	cp ${BUILD}/lib${LIBNAME}.so ${LIBDIR}/
	cp ${SRCDIR}/${LIBNAME}.sh ${BINDIR}/${LIBNAME}
	cp -r ${SRCDIR}/commands/ ${BINDIR}/.${LIBNAME}/
	chmod +x ${BINDIR}/${LIBNAME} ${BINDIR}/.${LIBNAME}/*
	echo "The library was successfully installed!"

clean:
	rm -rf ${BUILD}/

uninstall:
	echo "Uninstalling the library..."
	rm -rf ${LIBDIR}/lib${LIBNAME}.so ${INCLUDEDIR}/${LIBNAME}*
	echo "The library was successfully uninstalled!"
