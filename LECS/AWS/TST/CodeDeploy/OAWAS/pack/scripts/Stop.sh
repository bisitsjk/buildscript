#!/bin/sh

sh /usr2/apache-tomcat/instance/openapi/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/oa/ROOT.war /lotte/lecs/webapp/oa/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/oa/ROOT

sleep 1