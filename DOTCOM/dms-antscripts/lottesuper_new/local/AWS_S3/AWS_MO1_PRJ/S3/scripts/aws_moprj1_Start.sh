#!/bin/sh

cd /esuper/project/mobile

sleep 5

tar -xf MO_prj_WAS.tar

sleep 5

chmod -R 775 /esuper/project/mobile/

sleep 5

cp -f /esuper/project/mobile/WEB-INF/x2config/x2config-target.xml /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 1

cp -f /esuper/project/mobile/WEB-INF/x2config/log4jconfig-target.xml /esuper/project/mobile/WEB-INF/x2config/log4jconfig.xml

sleep 1

sh /usr2/apache-tomcat/instance/mobile11/bin/shutdown.sh

sleep 10

sh /usr2/apache-tomcat/instance/mobile11/bin/start.sh

sleep 10