#!/bin/sh

sh /usr2/apache-tomcat/instance/uniqlo/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/nuniqlo/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/uniqlo/bin/start.sh

sleep 60

rm -fr /lotte/lecs/webapp/nuniqlo/ROOT.war

sleep 1

cd /usr2/apache-tomcat/instance/uniqlo/work/Catalina/localhost/ROOT

rm -fr *

sleep 10

sh /usr1/home/jeus/scripts/precompile

sleep 1