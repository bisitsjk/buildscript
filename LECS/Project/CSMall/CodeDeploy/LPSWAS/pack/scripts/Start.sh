#!/bin/sh

sh /usr2/apache-tomcat/instance/lps/bin/shutdown.sh

sleep 5

rm -fr /lotte/lecs/webapp/lps/ROOT

sleep 1

sh /usr2/apache-tomcat/instance/lps/bin/start.sh

sleep 5
