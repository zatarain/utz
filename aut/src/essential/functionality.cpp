#include "functionality.hpp"

void essential::helloworld() {
	std::cout << greeting("world") << std::endl;
}

void essential::hi(const std::string& name) {
	if(!name.size()) {
		std::cerr << "No name was provided!" << std::endl;
	}
	std::cout << "Hi " << name << "!!" << std::endl;
}

std::string essential::greeting(const std::string& name) {
	if(!name.size()) {
		throw new std::invalid_argument("No name was provided!");
	}
	std::stringstream output;
	output << "Hello " << name << "!!";
	return output.str();
}

int essential::exceptional_division(int dividend, int divisor) {
	return dividend / divisor;
}