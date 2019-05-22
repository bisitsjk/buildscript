#!/bin/sh

cd /h2010/fo2

tar -xf fo2_PGPRJ_20171024_PROJECT_WEB.tar

sleep 5

tar -xf fo2_PGPRJ_20171024_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/fo2/webapp/ /h2010/fo2/APP-INF/ /h2010/fo2/webroot/

sleep 5

rm -fr /h2010/fo2/fo2_PGPRJ_20171024_PROJECT_WEB.tar
rm -fr /h2010/fo2/fo2_PGPRJ_20171024_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_FO2;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_FO2;