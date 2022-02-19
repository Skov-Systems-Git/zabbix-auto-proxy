# zabbix-auto-proxy

## The concept

### bash

1. Prompt for zabbix frontend url and api key
   1. export as env vars
2. Add $PROXY_PORT/tcp to firewalld
   1. Set as var in bash
3. Export all vars as envvars
4. Install zabbix rpm
5. Install zabbix-proxy and zabbix-agent2
6. Set up sqllite
7. SELinux (mayby python)
8. Run python script
9.  sudo chown -R /etc/zabbix zabbix:zabbix
10. sudo chmod 400 /etc/zabbix/${hostname}-proxy.psk
11. systemctl enable --now zabbix-proxy zabbix-agent2

### code

1. Use new Zabbix api keys as auth
2. Use hostname as name
3. Generate PSK and identity in script
4. Search/replace for agent and proxy configs: <https://www.codegrepper.com/code-examples/python/python+find+and+replace+string+in+file>
## sources

Simple zabbix auth example: <https://sbcode.net/zabbix/zabbix-api-python-example/>