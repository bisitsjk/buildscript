#!/bin/sh

sh /usr2/apache-tomcat/instance/gu/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/gu/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/gu/bin/start.sh

sleep 60

rm -fr /lotte/lecs/webapp/gu/ROOT.war

sleep 1

cd /usr2/apache-tomcat/instance/gu/work/Catalina/localhost/ROOT

rm -fr *

sleep 10

sh /usr1/home/jeus/scripts/precompile

sleep 1