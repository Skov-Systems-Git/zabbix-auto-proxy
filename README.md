# zabbix-auto-proxy

## The concept

### bash

1. Prompt for zabbix frontend url and api key
2. Add 10051/tcp to firewall
3. Install zabbix rpm
4. Install zabbix-proxy and zabbix-agent2
5. Set up sqllite
6. SELinux (mayby python)
7. Run python script
8. sudo chown -R /etc/zabbix zabbix:zabbix
9. sudo chmod 400 /etc/zabbix/${hostname}.psk
10. systemctl enable --now zabbix-proxy zabbix-agent2

### code

1. Use new Zabbix api keys as auth
2. Use hostname as name
3. Generate PSK and identity in script
4. Search/replace for agent and proxy configs: <https://www.codegrepper.com/code-examples/python/python+find+and+replace+string+in+file>
5. Use jinja template for agent config
## sources

Simple zabbix auth example: <https://sbcode.net/zabbix/zabbix-api-python-example/>