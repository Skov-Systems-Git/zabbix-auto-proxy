#!/bin/bash

## dotsource the config
. config.sh
## print env vars received
echo "########## VARS START #########"
echo "Zabbix frontend: $ZABBIX_FRONTEND"
echo "Zabbix API key: $ZABBIX_API_USER"
echo "Zabbix API key: $ZABBIX_API_KEY"
echo "Zabbix servers: $ZABBIX_SERVERS"
echo "Proxy firewall rule enabled: $ZABBIX_FIREWALL_CONF"
echo "Zabbix infrastructure port: $ZABBIX_INFRA_PORT"
echo "Zabbix proxy sqlite3 db path: $ZABBIX_DB_PATH/$ZABBIX_DB_NAME"
echo "Zabbix repo rpm: $ZABBIX_RPM"
echo "DNF dependencies: $DNF_INIT $DNF_DEPENDS"
echo "########## VARS END ##########"
echo ""

## add the firewall rule
if [ "$ZABBIX_FIREWALL_CONF" = true ] ; then
    echo "$(date +%FT%T.%3N%Z): Adding $ZABBIX_INFRA_PORT/tcp to firewalld default zone"
    sudo firewall-cmd --add-port=$ZABBIX_INFRA_PORT/tcp --permanent -q > /dev/null 2>&1
    sudo firewall-cmd --reload -q > /dev/null 2>&1
fi
## install the initial dependencies
echo "$(date +%FT%T.%3N%Z): Installing initial dependencies via dnf"
sudo dnf -q -y install {$DNF_INIT,$ZABBIX_RPM} > /dev/null 2>&1

## clean dnf cache
echo "$(date +%FT%T.%3N%Z): Cleaning DNF cache"
sudo dnf -q -y clean all > /dev/null 2>&1

## install deploy dependencies
echo "$(date +%FT%T.%3N%Z): Installing deploy dependencies via dnf"
sudo dnf -q -y install $DNF_DEPENDS > /dev/null 2>&1
