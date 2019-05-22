#!/bin/bash


WAS=localhost
WAS_HOST=`hostname`

CMD=$1
TARGET_CONTAINER=container1

if [ "$CMD" != "downcon" ] && [ "$CMD" != "startcon" ];then
        exit
fi

if [ "$TARGET_CONTAINER" == "" ]; then
        exit
fi

TARGET_HOST=$WAS
TARGET_HOSTNAME=$WAS_HOST


if [ "$TARGET_HOST" == "" ]; then
        exit
fi

CON_NAME="$TARGET_HOSTNAME"_"$TARGET_CONTAINER"

echo "HOST:$TARGET_HOST"
echo "HOSTNAME:$TARGET_HOSTNAME"
echo "CONTAINER:$TARGET_CONTAINER"
echo "CMD:$CMD"

/usr2/jeus6/bin/jeusadmin localhost -Uadministrator -Pjeusadmin  $CMD $CON_NAME
