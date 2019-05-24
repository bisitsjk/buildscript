#!/bin/bash

cp -f /esuper/project/mobile/WEB-INF/x2config/x2config-real.xml /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 10

touch /esuper/project/mobile/WEB-INF/x2config/x2config.xml

sleep 5

cp -f /esuper/project/mobile/WEB-INF/x2config/log4jconfig-real.xml /esuper/project/mobile/WEB-INF/x2config/log4jconfig.xml

sleep 10

touch /esuper/project/mobile/WEB-INF/x2config/log4jconfig.xml

sleep 5
