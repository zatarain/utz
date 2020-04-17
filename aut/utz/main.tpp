#include <utz.hpp>
#include <main.hpp>
#include <cstdlib>

void utz::test() {
	utz::log << "Starting main test cases..." << std::endl;
	const char* arguments[] = {"program", "argument"};
	int result = __real_main(2, arguments);
	int a = 3, b = 4;

	"main call success (result == EXIT_SUCCESS)"
		| expect(result, is::equal, EXIT_SUCCESS);

	"a = b"
		| expect(a, is::equal, b);

	"a = 3"
		| expect(a, is::equal, 3);

	(skip) "b = 1"
		| expect(b, is::equal, 3);

	utz::log << "All main test cases have finished!" << std::endl;
}
