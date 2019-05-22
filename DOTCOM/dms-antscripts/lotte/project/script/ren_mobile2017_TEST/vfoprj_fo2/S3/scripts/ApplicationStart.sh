#!/bin/sh

cd /h2010/fo2

tar -xf fo_ren_mobile2017_TEST_PROJECT_WEB.tar

sleep 5

tar -xf fo_ren_mobile2017_TEST_PROJECT_WAS.tar

sleep 5

/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin downcon vFOPRJ1_FO2;/usr2/jeus6/bin/jeusadmin `hostname` -Uadministrator -Pjeusadmin startcon vFOPRJ1_FO2;