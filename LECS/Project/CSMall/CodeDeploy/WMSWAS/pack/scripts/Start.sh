#!/bin/sh

sh /usr2/apache-tomcat/instance/wms/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/wms/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/wms/bin/start.sh

sleep 5
