#ifndef GENERIC
#define GENERIC
namespace essential {
	template<typename Type>
	void mygeneric(Type data) {

	}

	template<typename Type>
	class generic
	{
	private:
		Type data;
	public:
		generic(Type);
		~generic();
	};
}

#include "generic.cpp"

#endif