#!/bin/bash

mkdir -p /lotte/lecsDocs/temp/tmp
unzip -q /lotte/lecsDocs/temp/ -d /lotte/lecsDocs/temp/tmp

cd $TMPFILE/


ZIP_FILE=$1
TARGET_PATH=$2
REMOVE_OLD=$3

WORKDIR=/lotte/lecsDocs/temp/

echo "Zip File: $ZIP_FILE"
echo "Target Path: $TARGET_PATH"
exit 0

if [ ! -e ~/temp/$ZIP_FILE  ]; then
        echo "ZIP File is not exit"
        exit -1
fi

if [ ! -e $TARGET_PATH ]; then
        echo "Target path is not invalid"
        exit -1
fi


TMPFILE="$WORKDIR/$RANDOM.tmp"

echo "Make dir: $TMPFILE" 

mkdir  $TMPFILE
if [ ! -e $TMPFILE ]; then
        echo "Can not create tmp folder"
        exit -1 
fi


echo "Unzip zip file"
cd $TMPFILE/
unzip -q $WORKDIR/$ZIP_FILE 
cd -

if [ $REMOVE_OLD == "yes" ]; then
  mv $TARGET_PATH `echo $TARGET_PATH | sed 's#/*$##'`_`date "+%m%d_%H%M"`
fi

mkdir -p $TARGET_PATH  || true

echo "Move unzipped files"
cp -R $TMPFILE/* $TARGET_PATH/

echo "Remove tmp folder $TMPFILE"
rm -fR $TMPFILE

#chmod -R 777 $TARGET_PATH/