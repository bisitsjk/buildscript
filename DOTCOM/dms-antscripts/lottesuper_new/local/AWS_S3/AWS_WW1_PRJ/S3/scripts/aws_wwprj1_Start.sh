#!/bin/sh

cd /esuper/project/winwin

sleep 5

tar -xf WW_prj_WAS.tar

sleep 5

chmod -R 775 /esuper/project/winwin/

sleep 5

cp -f /esuper/project/winwin/WEB-INF/x2config/x2config-target.xml /esuper/project/winwin/WEB-INF/x2config/x2config.xml

sleep 1

sh /usr2/apache-tomcat/instance/winwin11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/winwin11/bin/start.sh

sleep 5