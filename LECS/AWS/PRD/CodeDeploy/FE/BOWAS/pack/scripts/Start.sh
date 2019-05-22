#!/bin/sh

sh /usr2/apache-tomcat/instance/bo/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/bo/ROOT

sleep 1

unzip -o -q /usr1/home/jeus/deploy/RULE.zip -d /lotte/lecsDocs/excel/rule

sleep 1

sh /usr2/apache-tomcat/instance/bo/bin/start.sh

sleep 5
