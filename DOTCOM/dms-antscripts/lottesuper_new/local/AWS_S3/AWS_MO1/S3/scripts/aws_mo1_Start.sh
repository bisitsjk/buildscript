#!/bin/sh

cd /usr1/home/jeus/deploy/


sleep 5

./ssh_modeploy deploy_id

sleep 5

cp -f /esuper/project/mobile/WEB-INF/x2config/x2config-target.xml /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 5

touch /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 5

cd /usr2/apache-tomcat/instance/mobile11/bin

sleep 1

./shutdown.sh

sleep 10

./start.sh

sleep 10