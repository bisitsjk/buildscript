#!/bin/sh

sh /usr2/apache-tomcat/instance/analyticsapi/bin/shutdown.sh

sleep 5

rm -fr /lotte/analytics/view/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/analyticsapi/bin/start.sh

sleep 5
