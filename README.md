# Unit Testing Zeal (utz)

This project aims to provide a library to make unit testing in C++ based on the standard library for those passionated to the unit testing, software development and C++ standard.

## Motivation
At the moment, the c++ standard is really limited regarding on unit testing, to say the less. Reviewing the state of the art, there are some libraries already like boost, GTest+GMock, FakeIt, catch, mettle, cute and many others. However, in terms of the mocking they are significant limited, for instance they can only mock virtual methods and some times a method was not designed as virtual and we are not the developer or maintainer for that method (which is likely when we try to mock something) or we even don't have access to the source code only the binaries.

## Tenets
* Provide a readable and maintainbale way to write assertions.
* Create mechanism to mock functions and methods (member functions) in run time.
* Provide an easy way to implement Data Driven Test (DDT).
* Try to reduce the ammount of macros needed to perform unit testing.
* Generate a report for test passed, failed and/or skipped, and include the coverage.
* Reduce the hassle of the current way to perform unit testing in C++.
* Avoid abbreviations as possible in the naming.

## Purposed syntax
Following subsections try to illustrate with some examples the initial purposed syntax \[the dream(?)\].

### Assertions
```C++
#include <utz/expect.hpp>
using utz::expect;
...
"Expecting 5 + 7 = 12."
  | expect(sum(5, 7), is::equal, 12);

"Expecting non-empty collection."
  | expect(collection.size(), is::greater, 0);

[[unlikely]]
"Expecting country table has the key 'MX'"
  | expect(contries, has::key, 'MX');
```
Sample output for those assertions:
```
[PASSED] Expecting 5 + 7 = 12.
[FAILED] Expecting non-empty collection.
[SKIPED] Expecting country table has the key 'MX'
```

### Mocking
```C++
#include <utz/mock.hpp>
#include <utz/expect.hpp>
using utz::expect;
...
utz::mock mymethod(&myclass::mymethod);
utz::mock logger(&log::error);
int x = 10, y = 20, z = 30;
when(mymethod, is::called_with, std::tuple(x, y)).then_return(0);
when(mymethod, is::called_with, std::tuple(z, x)).then_throw<std::out_of_range>();
function_under_test(x, y, z);

"Expecting mymethod was called 3 times within function_under_test."
  | expect(mymethod.number_of_calls(), is::equal, 3);

std::sprintf(
  "The second call (1-index) should be performed with '%d' and '%d' as arguments.", x, y
) | expect(mymethod.arguments_for_call(2), is::equal, std::tuple(x, y));

"The thrown error/exception should be logged."
  | expect(logger.number_of_calls(), is::equal, 1); 
```
Sample output for that test:
```
[PASSED] Expecting mymethod was called 3 times within function_under_test.
[FAILED] The second call (1-index) should be performed with '10' and '20' as arguments.
[PASSED] The thrown error/exception should be logged.
```

### Data Driven Test (DDT)
```C++
#include <utz/data.hpp>
#include <utz/expect.hpp>
using utz::expect;
...
void mytest_for_integer_division(int dividend, int divisor, const utz::behaviour& expected) {
  sprintf(
    "Integer division of %d over %d should %s.", dividend, divisor, expected.to_string()
  ) | expect(integer_division(dividend, divisor), has::behaviour, expected);
}
...
utz::suite{
    utz::test(mytest_for_integer_division, {
      {60, 20, utz::returns(3)},
      {10, 40, utz::returns(0)},
      {-1, 40, utz::returns(0)},
      {-6, -2, utz::returns(3)},
      {60, -9, utz::returns(6)},
      {-1, 40, utz::returns(0)},
      {-9, -2, utz::returns(4)},
      { 0, -2, utz::returns(0)},
      {-9,  0, utz::throws<std::invalid_argument>}},
    });
    
    utz::test(other_test, stream_of_data_provider);
};
```
That test cases should be generate something like following output:
```
...
[PASSED] Integer division of 60 over 20 should return 3.
[FAILED] Integer division of 10 over 40 should return 0.
[PASSED] Integer division of -1 over 40 should return 0.
[FAILED] Integer division of -6 over -2 should return 3.
[PASSED] Integer division of 60 over -9 should return 6.
[PASSED] Integer division of -1 over 40 should return 0.
[FAILED] Integer division of -9 over -2 should return 4.
[PASSED] Integer division of  0 over -2 should return 4.
[FAILED] Integer division of -9 over  0 should throw 'std::invalid_argument'.
...
```
