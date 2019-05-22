#!/bin/sh

sh /usr2/apache-tomcat/instance/muji/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/muji/ROOT.war /lotte/lecs/webapp/muji/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/muji/ROOT

sleep 1