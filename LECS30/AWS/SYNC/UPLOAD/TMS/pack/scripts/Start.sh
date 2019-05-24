#!/bin/bash

cd /esuper/project

tar -cvzf tms_sync.tar ./tms --exclude ./tms/WEB-INF/conf 

sleep 1

aws s3 cp tms_sync.tar s3://lotte.com-super-deploy/sync/tms_sync.tar --region ap-northeast-2

sleep 1

rm -fr /esuper/project/tms_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #