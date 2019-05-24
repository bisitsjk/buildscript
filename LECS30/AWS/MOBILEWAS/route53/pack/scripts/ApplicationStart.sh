#!/bin/bash

cp -f /esuper/project/mobile/WEB-INF/x2config/x2config-stg.xml /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 10

touch /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 5

cp -f /esuper/project/mobile/WEB-INF/x2config/log4jconfig-stg.xml /esuper/project/mobile/WEB-INF/x2config/log4jconfig.xml

sleep 10

touch /esuper/project/mobile/WEB-INF/x2config/log4jconfig.xml

sleep 5

cd /usr1/home/jeus/awsscript/route53

sh route53_real_super MOBILEWAS
