#!/bin/sh

cd /h2010/bo

tar -xf bo_DUALPG_2018_PROJECT_WEB.tar

sleep 5

tar -xf bo_DUALPG_2018_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/bo/webapp/ /h2010/bo/APP-INF/ /h2010/bo/webroot/

sleep 5

rm -fr /h2010/bo/bo_DUALPG_2018_PROJECT_WEB.tar
rm -fr /h2010/bo/bo_DUALPG_2018_PROJECT_WAS.tar

sleep 5

/usr2/apache-tomcat/instance/tomcat_executor.sh stop

sleep 5

/usr2/apache-tomcat/instance/tomcat_executor.sh start