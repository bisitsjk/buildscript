#!/bin/sh

sh /usr2/apache-tomcat/instance/gu/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/gu/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/gu/bin/start.sh

sleep 5
