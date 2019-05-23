#!/bin/sh

cd /usr2/apache-tomcat/instance/analytics/bin

./shutdown.sh

sleep 5

rm -fr /lotte/analytics/weblog/ROOT.war

sleep 5

rm -fr /lotte/analytics/weblog/ROOT

sleep 5



