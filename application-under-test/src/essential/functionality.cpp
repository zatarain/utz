#include "functionality.hpp"

void essential::helloworld() {
	std::cout << greeting("world") << std::endl;
}

void essential::hi(const std::string& name) {
	std::cout << "Hi " << name << "!!" << std::endl;
}

std::string essential::greeting(const std::string& name) {
	std::stringstream output;
	output << "Hello " << name << "!!";
	return output.str();
}

int essential::exceptional_division(int dividend, int divisor) {
	return dividend / divisor;
}