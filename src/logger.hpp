#ifndef LOGGER_HEADER
#define LOGGER_HEADER

#include <iostream>

namespace utz {
	class logger;
	typedef std::ostream& (*flusher)(std::ostream&);
}

utz::logger& operator<<(std::ostream&, utz::logger&);

template<typename Type>
utz::logger& operator<<(utz::logger&, const Type&);
utz::logger& operator<<(utz::logger&, const utz::flusher&);

namespace utz {
	class logger {
	public:
		logger(const std::string&, const std::string&);
		template<typename Type>
		friend logger& ::operator<<(logger&, const Type&);
		friend logger& ::operator<<(logger&, const utz::flusher&);
		friend logger& ::operator<<(std::ostream&, logger&);
	private:
		std::string tag;
		std::string end;
	};

	static std::ostream& log = std::clog << "\033[0m";
	static logger failed("\033[1;31m😢 [FAILED] ", " ❌\033[0m");
	static logger passed("\033[1;32m😄 [PASSED] ", " ✔️\033[0m");
	static logger skiped("\033[1;33m😏 [SKIP'D] ", " ➖\033[0m");
}

template<typename Type>
inline utz::logger& operator<<(utz::logger& logger, const Type& data) {
	utz::log << data;
	return logger;
}

#endif