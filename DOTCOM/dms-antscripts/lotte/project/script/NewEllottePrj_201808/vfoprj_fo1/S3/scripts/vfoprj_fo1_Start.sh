#!/bin/sh

cd /h2010/fo

tar -xf fo_NewEllottePrj_201808_PROJECT_WEB.tar

sleep 5

tar -xf fo_NewEllottePrj_201808_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/fo/webapp/ /h2010/fo/APP-INF/ /h2010/fo/webroot/

sleep 5

rm -fr /h2010/fo/fo_NewEllottePrj_201808_PROJECT_WEB.tar
rm -fr /h2010/fo/fo_NewEllottePrj_201808_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_FO;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_FO;