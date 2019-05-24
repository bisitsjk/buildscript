#!/bin/sh

cd /esuper/project/back

sleep 5

tar -xf PRO_prj_WAS.tar

sleep 5

cp -f /esuper/project/back/WEB-INF/x2config/x2config-target.xml /esuper/project/back/WEB-INF/x2config/x2config.xml

sleep 1

cp -f /esuper/project/back/WEB-INF/x2config/log4jconfig-target.xml /esuper/project/back/WEB-INF/x2config/log4jconfig.xml

sleep 1

sh /usr2/apache-tomcat/instance/back11/bin/shutdown.sh

sleep 10

sh /usr2/apache-tomcat/instance/back11/bin/start.sh

sleep 10

cd /esuper/project/partner

sleep 5

tar -xf PARTNER_prj_WAS.tar

sleep 5

cp -f /esuper/project/partner/WEB-INF/x2config/x2config-target.xml /esuper/project/partner/WEB-INF/x2config/x2config.xml

sleep 1

sh /usr2/apache-tomcat/instance/partner11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/partner11/bin/start.sh

sleep 5

rm -rf /esuper/project/back/PRO_prj_WAS.tar

sleep 1

rm -rf /esuper/project/partner/PARTNER_prj_WAS.tar