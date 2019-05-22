#!/bin/sh

sh /usr2/apache-tomcat/instance/muji/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/muji/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/muji/bin/start.sh

sleep 5
