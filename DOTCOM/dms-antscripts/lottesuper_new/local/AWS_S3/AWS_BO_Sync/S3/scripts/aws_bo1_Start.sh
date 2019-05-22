#!/bin/sh

cd /usr1/home/jeus/deploy/

sleep 5

./ssh_bodeploy deploy_id

sleep 5

cp -f /esuper/project/back/WEB-INF/x2config/x2config-target.xml /esuper/project/back/WEB-INF/x2config/x2config.xml

sleep 5

touch /esuper/project/back/WEB-INF/x2config/x2config.xml

sleep 5

cp -f /esuper/project/partner/WEB-INF/x2config/x2config-partner-target.xml /esuper/project/partner/WEB-INF/x2config/x2config.xml

sleep 5

touch /esuper/project/partner/WEB-INF/x2config/x2config.xml

sleep 5

cd /usr2/apache-tomcat/instance/back11/bin

sleep 1

./shutdown.sh

sleep 10

./start.sh

sleep 10

cd /usr2/apache-tomcat/instance/partner11/bin

sleep 1

./shutdown.sh

sleep 10

./start.sh

sleep 10