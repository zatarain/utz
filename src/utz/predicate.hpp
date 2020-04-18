#ifndef PREDICATE_HEADER
#define PREDICATE_HEADER

#include <functional>

namespace utz {
	template<typename... Arguments>
	class predicate: public std::function<bool(Arguments...)>
	{
	public:
		predicate(const std::function<bool(Arguments...)>&&);
		bool operator()(Arguments...);
	};
}

#include "predicate.cpp"

#endif
