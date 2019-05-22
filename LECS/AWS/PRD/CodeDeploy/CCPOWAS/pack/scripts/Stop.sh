#!/bin/sh

sh /usr2/apache-tomcat/instance/bo/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/bo/ROOT.war /lotte/lecs/webapp/bo/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/bo/ROOT

sleep 1