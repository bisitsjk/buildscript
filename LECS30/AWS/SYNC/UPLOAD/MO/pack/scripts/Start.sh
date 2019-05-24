#!/bin/bash

cd /esuper/project

tar -cvzf mobile_sync.tar ./mobile --exclude ./mobile/WEB-INF/x2log/ --exclude ./mobile/static-root/fileupload/ --exclude ./mobile/WEB-INF/x2config/

sleep 1

aws s3 cp mobile_sync.tar s3://lotte.com-super-deploy/sync/mobile_sync.tar --region ap-northeast-2

sleep 1

rm -fr /esuper/project/mobile_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #