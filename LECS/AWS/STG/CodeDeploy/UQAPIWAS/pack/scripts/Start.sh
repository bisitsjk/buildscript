#!/bin/sh

sh /usr2/apache-tomcat/instance/nqapi/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/nqoa/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/nqapi/bin/start.sh

sleep 60

rm -fr /lotte/lecs/webapp/nqoa/ROOT.war
