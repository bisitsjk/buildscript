#!/bin/sh

cd /h2010/bo2

tar -xf bo2_ren_mobile2017_20170717_PROJECT_WEB.tar

sleep 5

tar -xf bo2_ren_mobile2017_20170717_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/bo2/webapp /h2010/bo2/APP-INF /h2010/bo2/webroot

sleep 5

rm -fr /h2010/bo2/bo2_ren_mobile2017_20170717_PROJECT_WEB.tar
rm -fr /h2010/bo2/bo2_ren_mobile2017_20170717_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vBOPRJ1_pro2;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vBOPRJ1_pro2;