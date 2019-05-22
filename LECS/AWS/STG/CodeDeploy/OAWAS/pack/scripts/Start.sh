#!/bin/sh

sh /usr2/apache-tomcat/instance/openapi/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/oa/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/openapi/bin/start.sh

sleep 60

rm -fr /lotte/lecs/webapp/oa/ROOT.war
