#!/bin/sh

cd /h2010/mcgl

tar -xf mcgl_EllotteAI_20171020_PROJECT_WEB.tar

sleep 5

tar -xf mcgl_EllotteAI_20171020_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/mcgl/webapp/;chmod -R 775 /h2010/mcgl/webroot/

sleep 5

rm -fr /h2010/mcgl/mcgl_EllotteAI_20171020_PROJECT_WEB.tar
rm -fr /h2010/mcgl/mcgl_EllotteAI_20171020_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_MCGL;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_MCGL;