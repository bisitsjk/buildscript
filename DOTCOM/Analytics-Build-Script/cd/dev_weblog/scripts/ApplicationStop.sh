#!/bin/bash

cd /usr2/apache-tomcat/instance/analytics/bin

./shutdown.sh

sleep 5

mv /lotte/analytics/weblog/ROOT.war /lotte/analytics/weblog/ROOT.war.bak

sleep 5

rm -fr /lotte/analytics/weblog/ROOT

sleep 5



