#!/bin/sh

cd /h2010/mo

tar -xf mo_DUALPG_2018_PROJECT_WEB.tar

sleep 5

tar -xf mo_DUALPG_2018_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/mo/webapp/;chmod -R 775 /h2010/mo/webroot/

sleep 5

rm -fr /h2010/mo/mo_DUALPG_2018_PROJECT_WEB.tar
rm -fr /h2010/mo/mo_DUALPG_2018_PROJECT_WAS.tar

sleep 5

/usr2/apache-tomcat/instance/tomcat_executor.sh stop

sleep 5

/usr2/apache-tomcat/instance/tomcat_executor.sh start