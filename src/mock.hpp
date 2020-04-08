#ifndef MOCK_HEADER
#define MOCK_HEADER

#include <iostream>
#include <deque>
#include <tuple>
#include <functional>

namespace utz {
	template<typename Return = void, typename ...Arguments>
	class mock {
	private:
		std::function<Return(Arguments...)> function;
		std::deque<std::tuple<Arguments...> *> calls;
	public:
		mock(const std::function<Return(Arguments...)>&&);
		mock(Return f(Arguments...));
		//virtual ~mock();
		Return operator()(Arguments...);
		int number_of_calls() const;
		std::tuple<Arguments...>* arguments_for_call(int) const;
	};
}

#include "mock.cpp"

#endif