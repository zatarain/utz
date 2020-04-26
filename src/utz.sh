#!/bin/sh
: "
Unit Test Zeal [UTZ]
: "

export utz=$(basename "$0")
export utzdir=$(dirname "$0")/.$utz
. "$utzdir/.core"

command=$utzdir/$1
if [ $# -eq 0 ] || [ ! -x "$command" ] || echo "$command" | grep -Eq '/\.[^/]+$' ; then
	command=$utzdir/help
fi

if [ $# -ge 1 ]; then
	shift
fi

parse Testfile
"$command" "$@"
