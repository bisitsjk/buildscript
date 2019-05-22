#!/bin/sh

cd /h2010/mo2

tar -xf mo2_ren_mobile2017_20170717_PROJECT_WEB.tar

sleep 5

tar -xf mo2_ren_mobile2017_20170717_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/mo2/webapp/;chmod -R 775 /h2010/mo2/webroot/

sleep 5

rm -fr /h2010/mo2/mo2_ren_mobile2017_20170717_PROJECT_WEB.tar
rm -fr /h2010/mo2/mo2_ren_mobile2017_20170717_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_MO2;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_MO2;