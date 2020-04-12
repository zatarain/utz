#ifndef ASSERTION_HEADER
#define ASSERTION_HEADER

#include <tuple>
#include <utility>
#include <optional>
#include "predicate.hpp"
#include "logger.hpp"

namespace utz {
	template<typename ValueUnderTest, typename... Expected>
	struct assertion: public std::pair<
		predicate<ValueUnderTest, Expected...>*,
		std::tuple<ValueUnderTest, Expected...>
	> {
		assertion(
			predicate<ValueUnderTest, Expected...>*,
			const std::tuple<ValueUnderTest, Expected...>&&
		);
		bool operator()() const;
	};

	template<typename ValueUnderTest, typename... Expected>
	assertion<ValueUnderTest, Expected...> expect(
		ValueUnderTest,
		predicate<ValueUnderTest, Expected...>,
		Expected...
	);

	using skip = std::optional<std::string>;
}

template<typename Descriptor, typename ValueUnderTest, typename... Expected>
void operator|(
	const Descriptor&,
	const utz::assertion<ValueUnderTest, Expected...>&
);

#include "assertion.cpp"

#endif