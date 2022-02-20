#!/bin/bash

## dotsource the config
. config.sh
## print env vars received
echo ""
echo "#################### VARS #####################"
echo "Zabbix frontend: $ZABBIX_FRONTEND"
echo "Zabbix server: $ZABBIX_SERVER"
echo "Zabbix proxy firewall config: $ZABBIX_FIREWALL_CONF"
echo "Zabbix proxy port: $ZABBIX_PROXY_PORT"
echo "Zabbix proxy PSK identity: $PROXY_PSK_IDENT"
echo "Zabbix proxy PSK: $PROXY_PSK"
echo "#################### VARS #####################"
echo ""

## starting deploy
echo "$(date +%FT%T.%3N%Z): Starting!"

## add the firewall rule
if [ "$ZABBIX_FIREWALL_CONF" = true ] ; then
    echo "$(date +%FT%T.%3N%Z): Adding $ZABBIX_PROXY_PORT/tcp to firewalld default zone"
    sudo firewall-cmd --add-port=$ZABBIX_PROXY_PORT/tcp --permanent -q > /dev/null 2>&1
    sudo firewall-cmd --reload -q > /dev/null 2>&1
fi

## install the initial dependencies
echo "$(date +%FT%T.%3N%Z): Installing initial dependencies via dnf"
sudo dnf -q -y install $DNF_INIT $ZABBIX_RPM > /dev/null 2>&1

## clean dnf cache
echo "$(date +%FT%T.%3N%Z): Cleaning DNF cache"
sudo dnf -q -y clean all > /dev/null 2>&1

## install deploy dependencies
echo "$(date +%FT%T.%3N%Z): Installing deploy dependencies via dnf"
sudo dnf -q -y install $DNF_DEPENDS > /dev/null 2>&1
pip3 install --user -r requirements.txt > /dev/null 2>&1

## generate proxy config, and create proxy in Zabbix
echo "$(date +%FT%T.%3N%Z): Generating proxy config, and creating proxy via API"
./proxy-config.py

## place configs
echo "$(date +%FT%T.%3N%Z): Placing generated configs and updating file permissions"
sudo mv /tmp/.proxy-temp.conf /etc/zabbix/zabbix_proxy.conf
sudo cp templates/zabbix_agent2.conf /etc/zabbix/
echo $PROXY_PSK > /tmp/zabbix_proxy.psk
sudo mv /tmp/zabbix_proxy.psk /etc/zabbix/zabbix_proxy.psk

## make sure permissions are correct
cd /etc/zabbix
sudo chmod 400 zabbix_proxy.psk
sudo chown -R zabbix:zabbix $(ls -I web)

## enable services 
echo "$(date +%FT%T.%3N%Z): Enabling Zabbix proxy and agent services"
sudo systemctl enable --now zabbix-proxy zabbix-agent2 > /dev/null 2>&1

## Done!
echo "$(date +%FT%T.%3N%Z): Done!"
