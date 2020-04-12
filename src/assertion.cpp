#ifndef ASSERTION_IMPLEMENTATION
#define ASSERTION_IMPLEMENTATION

#include "assertion.hpp"

template<typename ValueUnderTest, typename... Expected>
utz::assertion<ValueUnderTest, Expected...>::assertion(
	utz::predicate<ValueUnderTest, Expected...>* predicate,
	const std::tuple<ValueUnderTest, Expected...>&& arguments
): std::pair<
	utz::predicate<ValueUnderTest, Expected...>*,
	std::tuple<ValueUnderTest, Expected...>
>(predicate, arguments) { }

template<typename ValueUnderTest, typename... Expected>
bool utz::assertion<ValueUnderTest, Expected...>::operator()() const {
	return std::apply(*(this->first), this->second);
}

#ifndef expect
template<typename ValueUnderTest, typename... Expected>
utz::assertion<ValueUnderTest, Expected...> utz::expect(
	ValueUnderTest value,
	utz::predicate<ValueUnderTest, Expected...> test,
	Expected... expected
) {
	std::tuple arguments(value, expected...);
	return utz::assertion<ValueUnderTest, Expected...>(&test, std::move(arguments));
}
#endif

template<typename Descriptor, typename ValueUnderTest, typename... Expected>
void operator|(
	const Descriptor& description,
	const utz::assertion<ValueUnderTest, Expected...>& assertion
) {
	utz::log << (assertion() ? utz::passed : utz::failed) << description << std::endl;
}

template<typename ValueUnderTest, typename... Expected>
void operator|(
	const utz::skip& description,
	const utz::assertion<ValueUnderTest, Expected...>& assertion
) {
	utz::log << utz::skiped << description.value() << std::endl;
}

#endif