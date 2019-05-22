#!/bin/sh

sh /usr2/apache-tomcat/instance/cc/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/cc/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/cc/bin/start.sh

sleep 5
