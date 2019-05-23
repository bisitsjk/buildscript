#!/bin/bash

cd /esuper/project

aws s3 cp s3://lotte.com-super-deploy/sync/back_sync.tar back_sync.tar --region ap-northeast-2

sleep 1

aws s3 cp s3://lotte.com-super-deploy/sync/partner_sync.tar partner_sync.tar --region ap-northeast-2

sleep 1

aws s3 cp s3://lotte.com-super-deploy/sync/sapi_sync.tar sapi_sync.tar --region ap-northeast-2

sleep 1

aws s3 cp s3://lotte.com-super-deploy/sync/tms_sync.tar tms_sync.tar --region ap-northeast-2

sleep 1

tar xvzf ./back_sync.tar -C /esuper/project

sleep 1

tar xvzf ./partner_sync.tar -C /esuper/project

sleep 1

tar xvzf ./sapi_sync.tar -C /esuper/project

sleep 1

tar xvzf ./tms_sync.tar -C /esuper/project

sleep 1

sh /usr2/apache-tomcat/instance/back11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/back11/bin/start.sh

sleep 1

sh /usr2/apache-tomcat/instance/partner11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/partner11/bin/start.sh

sleep 1

sh /usr2/apache-tomcat/instance/sapi11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/sapi11/bin/start.sh

sleep 1

sh /usr2/apache-tomcat/instance/tms11/bin/shutdown.sh

sleep 5

sh /usr2/apache-tomcat/instance/tms11/bin/start.sh

sleep 1

rm -fr /esuper/project/back_sync.tar

sleep 1

rm -fr /esuper/project/partner_sync.tar

sleep 1

rm -fr /esuper/project/sapi_sync.tar

sleep 1

rm -fr /esuper/project/tms_sync.tar

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #