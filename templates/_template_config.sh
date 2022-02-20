#!/bin/bash

# Environment specific variables
## set Zabbix frontend URL (ex. https://sub.dom.tld)
export ZABBIX_FRONTEND="https://changeme.domain.tld"

## Set Zabbix credential details
export ZABBIX_API_KEY="api_key"

## Set Zabbix servers
export ZABBIX_SERVER="zabbix-cluster.domain.tld"

## Open proxy port in local firewall?
export ZABBIX_FIREWALL_CONF=true

# Default variables, only change if necessary
## Zabbix proxy port
export ZABBIX_PROXY_PORT=10051

## Dependencies for the deployment
export ZABBIX_RPM="https://repo.zabbix.com/zabbix/6.0/rhel/8/x86_64/zabbix-release-6.0-1.el8.noarch.rpm"
export DNF_INIT="epel-release"
export DNF_DEPENDS="python3-devel sqlite zabbix-selinux-policy zabbix-sql-scripts zabbix-proxy-sqlite3 zabbix-agent2"

# Proxy settings
## timings
export PROXY_OFFLINE_BUFFER_HOURS=72
export PROXY_CONFIG_FREQ=30
export PROXY_VMWARE_FREQ=10

## processesing/gatherers
export PROXY_POLLERS=32
export PROXY_POLLERS_UNREACH=4
export PROXY_DISCOVERERS=4
export PROXY_DB_SYNCERS=8
export PROXY_VMWARE_COLLECTORS=64

## cache
export PROXY_VMWARE_CACHE_MB=64
export PROXY_CACHE_MB=128
export PROXY_HISTORY_CACHE_MB=256
export PROXY_HISTORY_INDEX_CACHE_MB=32

## psk settings
export PROXY_PSK_IDENT="PSK-$HOSTNAME"
export PROXY_PSK=$(openssl rand -hex 32)
