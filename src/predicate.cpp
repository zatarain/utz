#ifndef PREDICATE_IMPLEMENTATION
#define PREDICATE_IMPLEMENTATION

#include  "predicate.hpp"

template<typename... Arguments>
utz::predicate<Arguments...>::predicate(const std::function<bool(Arguments...)>&& function):
	std::function<bool(Arguments...)>(function) {

}

template<typename... Arguments>
bool utz::predicate<Arguments...>::operator()(Arguments... arguments) {
	return std::function<bool(Arguments...)>::operator()(arguments...);
}

namespace utz::is {
	template<typename Comparable>
	utz::predicate<Comparable, Comparable> equal([](
		Comparable actual,
		Comparable expected
	) -> bool { return actual == expected; });
}

#endif