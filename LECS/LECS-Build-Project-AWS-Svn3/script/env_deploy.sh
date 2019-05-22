#!/bin/bash

ADDR=$1
NAME=$2
echo ""
echo "Deploy Environment Files to $NAME($ADDR) "

echo "...JESUMain.xml to /usr2/jeus6/config/$NAME/"
sshpass -p +-Jeus77 scp serverside/jeus/$NAME/JEUSMain.xml jeus@$ADDR:/usr2/jeus6/config/$NAME/

echo "...WEBMain.xml  to /usr2/jeus6/config/$NAME/${NAME}_servlet_engine1/"
sshpass -p +-Jeus77 scp serverside/jeus/$NAME/WEBMain.xml jeus@$ADDR:/usr2/jeus6/config/$NAME/${NAME}_servlet_engine1/