#!/bin/sh

cd /usr2/apache-tomcat/instance/back11/bin

sleep 1

./shutdown.sh

sleep 10

./start.sh

sleep 10

cd /usr2/apache-tomcat/instance/partner11/bin

sleep 1

./shutdown.sh

sleep 10

./start.sh

sleep 10