#!/bin/sh

cd /h2010/mo

tar -xf mo_NPAY_20180405_PROJECT_WEB.tar

sleep 5

tar -xf mo_NPAY_20180405_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/mo/webapp/;chmod -R 775 /h2010/mo/webroot/

sleep 5

rm -fr /h2010/mo/mo_NPAY_20180405_PROJECT_WEB.tar
rm -fr /h2010/mo/mo_NPAY_20180405_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_MO;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_MO;