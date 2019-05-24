#!/bin/bash

cp -f /esuper/project/sapi/WEB-INF/x2config/x2config-real.xml /esuper/project/sapi/WEB-INF/x2config/x2config.xml

sleep 10

touch /esuper/project/sapi/WEB-INF/x2config/x2config.xml

sleep 5

cp -f /esuper/project/sapi/WEB-INF/x2config/log4jconfig-real.xml /esuper/project/sapi/WEB-INF/log4jconfig/x2config.xml

sleep 10

touch /esuper/project/sapi/WEB-INF/x2config/log4jconfig.xml

sleep 5
