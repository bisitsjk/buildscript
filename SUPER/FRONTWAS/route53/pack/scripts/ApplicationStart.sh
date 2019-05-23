#!/bin/bash

cp -f /esuper/project/front/WEB-INF/x2config/x2config-stg.xml /esuper/project/front/WEB-INF/x2config/x2config.xml

touch /esuper/project/front/WEB-INF/x2config/x2config.xml



cd /usr1/home/jeus/awsscript/route53

sh route53_real_super FRONTWAS
