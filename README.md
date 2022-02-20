# zabbix-auto-proxy

- [zabbix-auto-proxy](#zabbix-auto-proxy)
  - [Obtain your API key](#obtain-your-api-key)
  - [Deploy the prox](#deploy-the-prox)
  - [Example output](#example-output)
  - [Sources](#sources)

## Obtain your API key

**The user used for these steps needs super admin permissions**

1. https://your.zabbix.frontend/zabbix.php?action=user.token.list
2. "Create API token"
3. Limit as required

## Deploy the prox

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
Zabbix frontend: https://zabbix-frontend.domain.tld
Zabbix API key: <redacted>
Zabbix server: zabbix-lb.domain.tld
Zabbix proxy firewall config: true
Zabbix proxy port: 10051
Zabbix proxy PSK identity: PSK-PROXY
Zabbix proxy PSK: <redacted>
#################### VARS #####################

2022-02-20T01:35:32.796CET: Starting!
2022-02-20T01:35:32.798CET: Adding 10051/tcp to firewalld default zone
2022-02-20T01:35:33.818CET: Installing initial dependencies via dnf
2022-02-20T01:35:37.043CET: Cleaning DNF cache
2022-02-20T01:35:37.221CET: Installing deploy dependencies via dnf
2022-02-20T01:36:47.306CET: Generating proxy config, and creating proxy via API
2022-02-20T01:36:47.765CET: Placing generated configs and updating file permissions
2022-02-20T01:36:47.857CET: Enabling Zabbix proxy and agent services
2022-02-20T01:36:48.053CET: Done!
```

## Sources

* Zabbix API module: <https://github.com/lukecyca/pyzabbix>
* Jinja: <https://zetcode.com/python/jinja/>
* Zabbix API ref.: <https://www.zabbix.com/documentation/current/en/manual/api>
* Zabbix proxy doc.: https://www.zabbix.com/documentation/current/en/manual/appendix/config/zabbix_proxy