#include <utz.hpp>

void utz::test() {
	utz::log << "Starting test cases..." << std::endl;

	int a = 3, b = 4;

	"a = b"
		| expect(a, is::equal<int>, b);

	"a = 3"
		| expect(a, is::equal<int>, 3);

	(skip) "b = 1"
		| expect(b, is::equal<int>, 3);

	utz::log << "All test cases have finished!" << std::endl;
}
