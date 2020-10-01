#!/bin/sh

#test if a file is empty
#content="jhjh"
content=`cat $1`
if [ -z $content ]
then
	echo "File empty"
else
	echo "File not empty"
	echo $content
fi