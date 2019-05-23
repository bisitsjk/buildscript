#!/bin/bash

cd /esuper/project

tar -cvzf front_sync.tar ./front --exclude ./front/WEB-INF/x2log/ --exclude ./front/static-root/fileupload/ --exclude ./front/WEB-INF/x2config/

sleep 1

aws s3 cp front_sync.tar s3://lotte.com-super-deploy/sync/front_sync.tar --region ap-northeast-2

sleep 1

rm -fr /esuper/project/front_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #