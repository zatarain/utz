SRCDIR   = src
SOURCES  = `find ${SRCDIR}/ -type f -name "*.cpp"`
CXX		 = clang++ -std=c++17 -stdlib=libc++
CXXFLAGS = -Wall -Wno-comment -fPIC -pipe -I${SRCDIR}/
BUILD    = out
COVFLAGS = -fcoverage-mapping -fprofile-instr-generate -g -O0
LXXFLAGS = ${COVFLAGS} -shared

.SILENT: all application ${BUILD}/libaut.so

all: application ${BUILD}/libaut.so

${BUILD}/application:
	echo "Compiling example application..."
	echo "Source files:"
	echo -e ${SOURCES}
	mkdir -p ${@D}
	${CXX} ${CXXFLAGS} ${SOURCES} -o $@
	echo "The application was surccessfully compiled!"

${BUILD}/libaut.so:
	echo "Compiling application under test..."
	for source in ${SOURCES}; do\
		object=${@D}/$${source#*/};\
		object=$${object%.*}.o;\
		output=$${object%/*};\
		mkdir -p $$output;\
		echo ${CXX} ${CXXFLAGS} ${COVFLAGS} -c $$source -o $$object;\
		${CXX} ${CXXFLAGS} ${COVFLAGS} -c $$source -o $$object;\
		objects="$$objects $$object";\
	done; ${CXX} ${LXXFLAGS} $$objects -o $@
	echo "Surccessfully compiled application under test library!"
