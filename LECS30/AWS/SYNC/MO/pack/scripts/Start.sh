#!/bin/bash

cd /esuper/project

aws s3 cp s3://lotte.com-super-deploy/sync/mobile_sync.tar mobile_sync.tar --region ap-northeast-2

sleep 1

tar xvzf ./mobile_sync.tar -C /esuper/project

sleep 1

sh /usr2/apache-tomcat/instance/mobile11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/mobile11/bin/start.sh

sleep 1

rm -fr /esuper/project/mobile_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #