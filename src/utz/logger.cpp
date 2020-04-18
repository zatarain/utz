#ifndef LOGGER_IMPLEMENTATION
#define LOGGER_IMPLEMENTATION

#include "logger.hpp"

utz::logger::logger(const std::string& tag, const std::string& end): tag(tag), end(end) {

}

utz::logger& operator<< (std::ostream& output, utz::logger& logger) {
	output << logger.tag;
	return logger;
}

utz::logger& operator<<(utz::logger& logger, const utz::flusher& flusher) {
	utz::log << logger.end << flusher;
	return logger;
}

#endif