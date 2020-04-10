#ifndef MOCK_IMPLEMENTATION
#define MOCK_IMPLEMENTATION

#include "mock.hpp"

template<typename Return, typename ...Arguments>
utz::mock<Return, Arguments...>::mock(const std::function<Return(Arguments...)>&& f): function(f) {
	utz::log << "\033[1;32m"
		<< "Creating mock for function: " << typeid(f).name()
		<< "\033[0m" << std::endl;
}

template<typename Return, typename ...Arguments>
utz::mock<Return, Arguments...>::mock(Return f(Arguments...)): mock(std::function(f)) { }

template<typename Return, typename ...Arguments>
Return utz::mock<Return, Arguments...>::operator()(Arguments... arguments) {
	calls.push_back(new std::tuple(arguments...));
	return function(arguments...);
}

template<typename Return, typename ...Arguments>
int utz::mock<Return, Arguments...>::number_of_calls() const {
	return calls.size();
}

template<typename Return, typename ...Arguments>
std::tuple<Arguments...>* utz::mock<Return, Arguments...>::arguments_for_call(int index) const {
	return calls[index];
}

#endif