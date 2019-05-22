#!/bin/sh

sh /usr2/apache-tomcat/instance/lps/bin/shutdown.sh

sleep 5

mv -f /lotte/lecs/webapp/lps/ROOT.war /lotte/lecs/webapp/lps/ROOT.war.bak

sleep 1

rm -fr /lotte/lecs/webapp/lps/ROOT

sleep 1