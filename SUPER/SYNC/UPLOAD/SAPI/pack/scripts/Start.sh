#!/bin/bash

cd /esuper/project

tar -cvzf sapi_sync.tar ./sapi --exclude ./sapi/WEB-INF/x2config/

sleep 1

aws s3 cp sapi_sync.tar s3://lotte.com-super-deploy/sync/sapi_sync.tar --region ap-northeast-2

sleep 1

rm -fr /esuper/project/sapi_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #