# zabbix-auto-proxy

- [zabbix-auto-proxy](#zabbix-auto-proxy)
  - [Obtain your API key](#obtain-your-api-key)
  - [Deploy the proxy](#deploy-the-proxy)
  - [Example output](#example-output)
  - [Sources](#sources)

## Obtain your API key

**The user used for these steps needs super admin permissions**

1. https://your.zabbix.frontend/zabbix.php?action=user.token.list
2. "Create API token"
3. Limit as required

## Deploy the proxy

**The user used for thees steps needs full sudo permissions**

```bash
sudo dnf install git -y
git clone https://github.com/Skov-Systems-Git/zabbix-auto-proxy.git
cd zabbix-auto-proxy
cp templates/_template_config.sh config.sh
# edit config.sh with an editor, change necessary variables
./setup.sh
```
## Example output

```
[usr@PROXY t]$ ./setup.sh 

#################### VARS #####################
Zabbix frontend: https://zabbix-frontend-lb.dom.tld
Zabbix server: zabbix-ha-lb.dom.tld
Zabbix proxy firewall config: true
Zabbix proxy port: 10051
Zabbix proxy PSK identity: PSK-PROXY
Zabbix proxy PSK: 7459c637b19847a4724802f41117937d975c75dfe1a4572bf37ca682e6348e43
#################### VARS #####################

2022-02-20T03:31:22.134CET: Starting!
2022-02-20T03:31:22.135CET: Adding 10051/tcp to firewalld default zone
2022-02-20T03:31:23.155CET: Installing initial dependencies via dnf
2022-02-20T03:31:26.480CET: Cleaning DNF cache
2022-02-20T03:31:26.659CET: Installing deploy dependencies via dnf
2022-02-20T03:32:11.109CET: Generating proxy config, and creating proxy via API
2022-02-20T03:32:11.577CET: Placing generated configs and updating file permissions
2022-02-20T03:32:11.670CET: Enabling Zabbix proxy and agent services
2022-02-20T03:32:11.839CET: Zabbix proxy service is active
2022-02-20T03:32:11.848CET: Zabbix agent2 service is active
2022-02-20T03:32:11.855CET: Deploy done!
```

## Sources

* Zabbix API module: <https://github.com/lukecyca/pyzabbix>
* Jinja: <https://zetcode.com/python/jinja/>
* Zabbix API ref.: <https://www.zabbix.com/documentation/current/en/manual/api>
* Zabbix proxy doc.: https://www.zabbix.com/documentation/current/en/manual/appendix/config/zabbix_proxy