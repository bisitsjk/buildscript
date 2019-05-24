#!/bin/bash

cd /esuper/project

tar -cvzf back_sync.tar ./back --exclude ./back/WEB-INF/x2log/ --exclude ./back/static-root/fileupload/ --exclude ./back/static-root/ep/ --exclude ./back/WEB-INF/x2config --exclude ./back/WEB-INF/jsp/common/include/_js.jsp --exclude ./back/WEB-INF/jsp/common/include/_js_popup.jsp --exclude ./back/WEB-INF/jsp/ubireport/License.xml 

sleep 1

tar -cvzf partner_sync.tar ./partner --exclude ./partner/WEB-INF/x2log/ --exclude ./partner/static-root/fileupload/ --exclude ./partner/WEB-INF/x2config

sleep 1

aws s3 cp back_sync.tar s3://lotte.com-super-deploy/sync/back_sync.tar --region ap-northeast-2

sleep 1

aws s3 cp partner_sync.tar s3://lotte.com-super-deploy/sync/partner_sync.tar --region ap-northeast-2

sleep 1

rm -fr /esuper/project/back_sync.tar

sleep 1

rm -fr /esuper/project/partner_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #