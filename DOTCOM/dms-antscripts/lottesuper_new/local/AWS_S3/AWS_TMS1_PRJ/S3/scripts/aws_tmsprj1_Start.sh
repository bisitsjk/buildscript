#!/bin/sh

cd /esuper/project/tms

sleep 5

tar -xf TMS_prj_WAS.tar

sleep 5

chmod -R 775 /esuper/project/tms/

sleep 5

cp -f /esuper/project/back/WEB-INF/x2config/x2config-target.xml /esuper/project/back/WEB-INF/x2config/x2config.xml

sleep 1

sh /usr2/apache-tomcat/instance/tms11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/tms11/bin/start.sh

sleep 5