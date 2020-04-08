#include "assertion.hpp"
#include "mock.hpp"

namespace is = utz::is;
using utz::expect;
using utz::skip;

int main(int argc, char const *argv[]) {
	std::ios_base::sync_with_stdio(false);
	std::cin.tie(NULL);

	int a = 3, b = 4;

	"a = b"
		| expect(a, is::equal<int>, b);

	"a = 3"
		| expect(a, is::equal<int>, 3);

	(skip) "b = 1"
		| expect(b, is::equal<int>, 3);

	return 0;
}
