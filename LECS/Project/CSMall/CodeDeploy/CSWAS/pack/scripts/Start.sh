#!/bin/sh

sh /usr2/apache-tomcat/instance/cs/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/lottecs/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/cs/bin/start.sh

sleep 5
