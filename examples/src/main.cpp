#include <iostream>
#include "essential/functionality.hpp"

int main(int argc, char const *argv[]) {
	std::ios_base::sync_with_stdio(false);
	std::cin.tie(NULL);

	essential::helloworld();
	essential::hi("Ulises");
	std::cout << "Exceptional Division: 7/4" <<
		essential::exceptional_division(7, 4) << std::endl;
	return 0;
}
