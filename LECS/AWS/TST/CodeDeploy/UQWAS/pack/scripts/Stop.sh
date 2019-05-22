#!/bin/sh

sh /usr2/apache-tomcat/instance/uniqlo/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/nuniqlo/ROOT.war /lotte/lecs/webapp/nuniqlo/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/nuniqlo/ROOT

sleep 1