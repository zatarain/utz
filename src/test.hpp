#ifndef TEST_HEADER
#define TEST_HEADER

#include <cstdlib>
#include "logger.hpp"

extern "C" {
	int __real_main(int, const char* []);
	int __wrap_main(int, const char* []);
}

void __test__();

extern "C++" {
	namespace utz {
		void test();
		inline namespace callback {
			void setup();
			void before();
			void testcase();
			void result();
			void after();
			void teardown();
		}
	}
}
#endif