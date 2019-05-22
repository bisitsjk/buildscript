#!/bin/bash

COMPRESS_BOUNDARY="+3"

DELETE_LIMIT_WAS="+60"
DELETE_LIMIT_WEB="+60"

HOSTNAME=`hostname`

if [[ $HOSTNAME == muji* ]]; then
	DELETE_LIMIT_WAS="+30"
	if [[ $HOSTNAME == *web* ]]; then
		DELETE_LIMIT_WEB="+14"
	fi	
fi

function clean {
	DIR=$1
	LIMIT=$2

	if [[ -d $DIR ]]; then
		echo "Delete very old logs($LIMIT days ago) from $DIR"
		echo "	find $DIR -name \*.gz -mtime $LIMIT -print -exec rm {} \;"
		
		echo "Compress old logs($COMPRESS_BOUNDARY days ago)  from $DIR"
		echo "	find $DIR -name \*.log* -mtime $COMPRESS_BOUNDARY -print | grep -v gz | xargs gzip"
	fi
	
}

clean /usr3/lecs-log $DELETE_LIMIT_WAS
clean /usr3/web-log $DELETE_LIMIT_WEB
