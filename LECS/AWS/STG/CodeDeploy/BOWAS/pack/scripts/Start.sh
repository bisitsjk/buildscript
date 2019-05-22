#!/bin/sh

unzip -o -q /lotte/lecsDocs/temp/RULE.zip -d /lotte/lecsDocs/excel/rule

sleep 1

sh /usr2/apache-tomcat/instance/bo/bin/start.sh

sleep 5
