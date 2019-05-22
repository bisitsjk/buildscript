#!/bin/bash
~/bin/resizereq.sh
scp -r jeus@210.93.129.163:/lotte/lecsDocs/images/MJS1/ /lotte/lecsDocs/images/MJS1/
sleep 60
~/bin/resizeres.sh