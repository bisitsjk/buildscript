#!/bin/bash

cd /usr2/apache-tomcat/instance/analyticsapi/bin

./shutdown.sh

sleep 5

mv /lotte/analytics/api/ROOT.war /lotte/analytics/api/ROOT.war.bak

sleep 5

rm -fr /lotte/analytics/api/ROOT

sleep 5



