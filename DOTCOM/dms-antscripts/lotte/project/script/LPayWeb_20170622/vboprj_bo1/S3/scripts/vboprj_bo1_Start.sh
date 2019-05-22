#!/bin/sh

cd /h2010/bo

tar -xf bo_LPayWeb_20170622_PROJECT_WEB.tar

sleep 5

tar -xf bo_LPayWeb_20170622_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/bo/webapp /h2010/bo/APP-INF /h2010/bo/webroot

sleep 5

rm -fr /h2010/bo/bo_LPayWeb_20170622_PROJECT_WEB.tar
rm -fr /h2010/bo/bo_LPayWeb_20170622_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vBOPRJ1_pro;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vBOPRJ1_pro;