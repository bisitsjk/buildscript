#!/bin/sh

cd /usr1/home/jeus/deploy/


sleep 5

./ssh_sapideploy_long deploy_id

sleep 5

cd /usr2/apache-tomcat/instance/sapi11/bin

sleep 1

./shutdown.sh

sleep 10

./start.sh

sleep 10