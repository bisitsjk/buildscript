#!/bin/sh

cd /h2010/gl

tar -xf gl_EllotteAI_20171020_PROJECT_WEB.tar

sleep 5

tar -xf gl_EllotteAI_20171020_PROJECT_WAS.tar

sleep 5

chmod -R 775 /h2010/gl/webapp/;chmod -R 775 /h2010/gl/webroot/

sleep 5

rm -fr /h2010/gl/gl_EllotteAI_20171020_PROJECT_WEB.tar
rm -fr /h2010/gl/gl_EllotteAI_20171020_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_GL;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_GL;