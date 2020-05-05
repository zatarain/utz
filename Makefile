.POSIX:
# Recomended variables/macros for installation
DESTDIR    =
PREFIX     = /usr
BINDIR     = ${DESTDIR}${PREFIX}/bin
LIBDIR     = ${DESTDIR}${PREFIX}/lib
INCLUDEDIR = ${DESTDIR}${PREFIX}/include
DATADIR    = ${DESTDIR}${PREFIX}/share
MANDIR     = ${DATADIR}/man
SRCDIR     = src
CXX	   = clang++ -std=c++17 -stdlib=libc++

# Macro/variables specific for the library
BUILD      = out
CXXFLAGS   = -Wall -Wno-comment -fPIC -O2 -pipe -I${SRCDIR}/
LXXFLAGS   = -shared
LIBNAME    = utz

.SILENT: clean install uninstall

.DEFAULT:
	@echo "Defaulting $@..."
	@chmod +x Default.mk
	@./Default.mk "$@"

${BUILD}/lib${LIBNAME}.so: ${OBJECTS}
	@if [ -z "${OBJECTS}" ]; then \
		make .configuration:$@;\
	else \
		echo "${CXX} ${CXXFLAGS} ${LXXFLAGS} ${OBJECTS} -o $@";\
		${CXX} ${CXXFLAGS} ${LXXFLAGS} ${OBJECTS} -o $@;\
	fi

install: ${BUILD}/lib${LIBNAME}.so
	echo "We are about to install the library."
	cp -rv ${SRCDIR}/${LIBNAME}.hpp ${SRCDIR}/${LIBNAME} ${INCLUDEDIR}/
	cp -v ${BUILD}/lib${LIBNAME}.so ${LIBDIR}/
	cp -v ${SRCDIR}/${LIBNAME}.sh ${BINDIR}/${LIBNAME}
	cp -rv ${SRCDIR}/commands/ ${BINDIR}/.${LIBNAME}/
	chmod +x ${BINDIR}/${LIBNAME} ${BINDIR}/.${LIBNAME}/*
	echo "The library was successfully installed!"

clean:
	rm -rf ${BUILD}/

uninstall:
	echo "Uninstalling the library..."
	rm -rfv ${LIBDIR}/lib${LIBNAME}.so ${INCLUDEDIR}/${LIBNAME}* \
			${BINDIR}/${LIBNAME} ${BINDIR}/.${LIBNAME}/
	echo "The library was successfully uninstalled!"
