#!/bin/sh

cd /usr1/home/jeus/deploy/

sleep 5

./ssh_wwdeploy deploy_id

sleep5

cd /usr2/apache-tomcat/instance/winwin11/bin

sleep 1

./shutdown.sh

sleep 5

./start.sh

sleep 5

