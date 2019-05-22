#!/bin/sh

cd /usr1/home/jeus/deploy/

sleep 5

./ssh_tmdeploy deploy_id

sleep5

cd /usr2/apache-tomcat/instance/tms11/bin

sleep 1

./shutdown.sh

sleep 5

./start.sh

sleep 5

