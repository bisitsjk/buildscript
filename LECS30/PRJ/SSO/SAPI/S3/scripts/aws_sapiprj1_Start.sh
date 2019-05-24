#!/bin/sh

cd /esuper/project/sapi

sleep 5

tar -xf SAPI_prj_WAS.tar

sleep 5

chmod -R 775 /esuper/project/sapi/

sleep 5

cp -f /esuper/project/sapi/WEB-INF/x2config/x2config-target.xml /esuper/project/sapi/WEB-INF/x2config/x2config.xml

sleep 10

cp -f /esuper/project/sapi/WEB-INF/x2config/log4jconfig-target.xml /esuper/project/sapi/WEB-INF/x2config/log4jconfig.xml

sleep 10

touch /esuper/project/sapi/WEB-INF/x2config/x2config.xml

sleep 5

touch /esuper/project/sapi/WEB-INF/x2config/log4jconfig.xml

sleep 5

sh /usr2/apache-tomcat/instance/sapi11/bin/shutdown.sh

sleep 10

sh /usr2/apache-tomcat/instance/sapi11/bin/start.sh

sleep 10

#rm -rf /usr1/home/jeus/workdir/SAPI_prj_WAS.tar