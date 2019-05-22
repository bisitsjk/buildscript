#!/bin/bash
function collect {
  ip=$1
  host=$2
  echo "$host"
  
  sshpass -p +-Jeus77 scp jeus@121.254.239.$ip:/usr2/jeus6/config/$host/JEUSMain.xml serverside/jeus/$host/
  sshpass -p +-Jeus77 scp jeus@121.254.239.$ip:/usr2/jeus6/config/$host/${host}_servlet_engine1/WEBMain.xml serverside/jeus/$host/
}

function collectWebtob {
  ip=$1
  host=$2
  echo "$host"
  sshpass -p +-Jeus77 scp jeus@121.254.239.$ip:/usr2/webtob/config/* serverside/webtob/$host/
}


collect 15 mujiwas1
collect 17 mujiwas2
collect 19 nikewas1
collect 21 nikewas2
collect 23 lpswas1
collect 25 lpswas2
collect 27 bowas1
collect 29 bowas2
collect 31 ccwas1
collect 33 ccwas2
collect 35 powas1
collect 37 powas2
collect 38 batchapp


collectWebtob 14 mujiweb1
collectWebtob 16 mujiweb2
collectWebtob 18 nikeweb1
collectWebtob 20 nikeweb2
collectWebtob 22 lpsweb1
collectWebtob 24 lpsweb2
collectWebtob 26 boweb1
collectWebtob 28 boweb2
collectWebtob 30 ccweb1
collectWebtob 32 ccweb2
collectWebtob 34 poweb1
collectWebtob 36 poweb2

echo "batchapp have no webtob"






