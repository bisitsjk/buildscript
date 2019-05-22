#!/bin/sh

cd /usr1/home/xclass/deploy/

sleep 5

./ssh_badeploy deploy_id

sleep 5

chmod -R 775 /esuper/project/batch

sleep 5