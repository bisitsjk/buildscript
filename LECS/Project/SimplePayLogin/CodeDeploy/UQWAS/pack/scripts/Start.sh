#!/bin/sh

sh /usr2/apache-tomcat/instance/uniqlo/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/nuniqlo/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/uniqlo/bin/start.sh

sleep 5
