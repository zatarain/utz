#include "test.hpp"

int __wrap_main(int argc, char* argv[]) {
	std::ios_base::sync_with_stdio(false);
	std::cin.tie(NULL);
	__test__();
	return EXIT_SUCCESS;
}

void __test__() {
	utz::log << "~~> Starting unit testing zeal..." << std::endl;

	utz::test();

	utz::log << "~~> Exiting unit testing zeal..." << std::endl;
}