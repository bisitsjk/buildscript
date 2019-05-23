#!/bin/bash

cd /usr2/apache-tomcat/instance/analyticsapi/bin

./shutdown.sh

sleep 1

rm -fr /lotte/analytics/api/ROOT.war

sleep 1

rm -fr /lotte/analytics/api/ROOT

sleep 5

cp /usr1/home/jeus/ROOT.war /lotte/analytics/api/ROOT.war

sleep 5

cd /usr2/apache-tomcat/instance/analyticsapi/bin

./start.sh

sleep 1

rm -fr /usr1/home/jeus/ROOT.war

sleep 10
