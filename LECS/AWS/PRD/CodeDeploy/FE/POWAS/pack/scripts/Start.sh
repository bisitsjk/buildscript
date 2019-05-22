#!/bin/sh

sh /usr2/apache-tomcat/instance/po/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/po/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/po/bin/start.sh

sleep 5
