#!/bin/sh

cd /usr1/home/xclass/deploy/

sleep 5

./ssh_obdeploy deploy_id

sleep 5

chmod -R 775 /usr2/LOTTESUPER/BIN/shell/

sleep 5

