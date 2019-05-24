#!/bin/bash

cd /esuper/project

aws s3 cp s3://lotte.com-super-deploy/sync/front_sync.tar front_sync.tar --region ap-northeast-2

sleep 1

tar xvzf ./front_sync.tar -C /esuper/project

sleep 1

sh /usr2/apache-tomcat/instance/front11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/front11/bin/start.sh

sleep 1

rm -fr /esuper/project/front_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #