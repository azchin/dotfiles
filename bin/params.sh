#!/bin/sh

file="$0"
while [ $# -gt 0 ] ; do
	flag=$1
	case "$flag" in
		"-f"|"--file")
			shift 1
			file="$1"
			[ -z "$file" ] && echo "no file provided" && exit 1
			;;
		*)
			echo "unknown parameter ${1}"
			exit 1
			;;
	esac
	shift 1
done

cat $file
