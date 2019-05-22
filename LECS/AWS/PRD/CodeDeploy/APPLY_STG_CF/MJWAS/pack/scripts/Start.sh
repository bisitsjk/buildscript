#!/bin/sh

cp /usr1/home/jeus/configfile/config_lecs.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/lecs/config_lecs.xml

cp /usr1/home/jeus/configfile/config_salt.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/salt/config_salt.xml

cp /usr1/home/jeus/configfile/common.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/spring/bean/common.xml

cp /usr1/home/jeus/configfile/interfaces.properties.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/interfaces.properties

cp /usr1/home/jeus/configfile/CancelRefund.properties.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/CancelRefund.properties

cp /usr1/home/jeus/configfile/Mcash.properties.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/Mcash.properties


cp /usr1/home/jeus/configfile/config_muji.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/muji/config_muji.xml

cp /usr1/home/jeus/configfile/LECS-Store-Muji/log4j.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/log4j/log4j.xml

cp /usr1/home/jeus/configfile/spring_properties.properties.main.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/spring/common/spring_properties.properties

sleep 1

sync

sleep 1

sync

sleep 1

sync