#!/bin/bash
## Environment specific variables
# set Zabbix frontend URL (ex. https://sub.dom.tld)
export ZABBIX_FRONTEND="https://changeme.domain.tld"
# Set Zabbix credential details
export ZABBIX_API_USER="api_user"
export ZABBIX_API_KEY="api_key"
# Set Zabbix servers, seperated by space
export ZABBIX_SERVERS="Server01 Server02:10051"
# Open proxy port in local firewall?
export ZABBIX_FIREWALL_CONF=true

## Default variables, only change if required
# Zabbix server/proxy default port
export ZABBIX_INFRA_PORT=10051
# Zabbix rpm URL
export ZABBIX_RPM="https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-1.el8.noarch.rpm"
# Dependencies for the deployment
export DNF_INIT="epel-release"
export DNF_DEPENDS="sqlite zabbix-selinux-policy zabbix-sql-scripts zabbix-proxy-sqlite3 zabbix-agent2"
