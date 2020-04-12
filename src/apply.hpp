#ifndef APPLY_HEADER
#define APPLY_HEADER

/**
 *	Accepts any number of arguments >= N, but only expands to the Nth one.
 *	Here, N = 8.
 *	From: https://codecraft.co/2014/11/25/variadic-macros-tricks/
 */
#define __GET_NTH__(_1, _2, _3, _4, _5, _6, _7, _N, ...) _N

/**
 *	Define some macros to help us create overrides based on the
 *	arity of a for-each-style macro.
 */
#define __EACH_CALL__0(call, ...)
#define __EACH_CALL__1(call, head) call(head)
#define __EACH_CALL__2(call, head, ...) call(head) __EACH_CALL__1(call, __VA_ARGS__)
#define __EACH_CALL__3(call, head, ...) call(head) __EACH_CALL__2(call, __VA_ARGS__)
#define __EACH_CALL__4(call, head, ...) call(head) __EACH_CALL__3(call, __VA_ARGS__)
#define __EACH_CALL__5(call, head, ...) call(head) __EACH_CALL__4(call, __VA_ARGS__)
#define __EACH_CALL__6(call, head, ...) call(head) __EACH_CALL__5(call, __VA_ARGS__)

/**
 *	Provide a for-each construct for variadic macros. Supports up
 *	to 6 args.
 *
 *	Example usage 1:
 *  	#define FORWARD_DECLARE_CLASS(clazz) class clazz;
 *  	__APPLY_MACRO__(FORWARD_DECLARE_CLASS, Foo, Bar)
 *
 *	Example usage 2:
 *  	#define START_NAMESPACE(space) namespace space {
 *  	#define END_NAMESPACE(space) }
 *  	#define MY_NAMESPACES system, net, http
 *  	__APPLY_MACRO__(START_NAMESPACE, MY_NAMESPACES)
 *  	typedef foo int;
 *  	__APPLY_MACRO__(END_NAMESPACE, MY_NAMESPACES)
 */
#define __APPLY_MACRO__(function, ...) \
    __GET_NTH__("ignored", ##__VA_ARGS__, \
    __EACH_CALL__6, __EACH_CALL__5, __EACH_CALL__4, \
	__EACH_CALL__3, __EACH_CALL__2, __EACH_CALL__1, \
	__EACH_CALL__0)(function, ##__VA_ARGS__)

#endif
