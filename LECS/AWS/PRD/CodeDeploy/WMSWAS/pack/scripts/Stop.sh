#!/bin/sh

sh /usr2/apache-tomcat/instance/wms/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/wms/ROOT.war /lotte/lecs/webapp/wms/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/wms/ROOT

sleep 1