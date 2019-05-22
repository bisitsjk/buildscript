#!/bin/sh

mv /lotte/lecs/batch /lotte/lecs/batch_bak

sleep 1 

unzip -o -q /usr1/home/jeus/deploy/Batch.zip -d /lotte/lecs/batch

sleep 1

chmod +x /lotte/lecs/batch/bin/*.sh

sleep 1