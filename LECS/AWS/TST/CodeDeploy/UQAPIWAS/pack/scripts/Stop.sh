#!/bin/sh

sh /usr2/apache-tomcat/instance/nqapi/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/nqoa/ROOT.war /lotte/lecs/webapp/nqoa/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/nqoa/ROOT

sleep 1