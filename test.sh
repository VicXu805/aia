#!/bin/bash
while getopts "a:bc" arg
do 
	case $arg in
	a)
	echo "a's arg:$OPTARG"
	;;
	b)
	echo "b"
	;;
	c)
	echo "c"
	;;
	*)
	echo "unknow argument"
	exit 1
	;;
	esac
done
