#!/usr/bin/env python3

import os
from pyzabbix import ZabbixAPI
from jinja2 import Environment, FileSystemLoader

def main():
    """
    * This script uses jinja templating to generate a Zabbix proxy config from env vars.
    * The script then creates the proxy object on the defined Zabbix frontend with generated PSK settings.
    """
    # Load env vars from config.sh to variables in python
    zabbix_frontend_url: str = os.environ.get("ZABBIX_FRONTEND")
    zabbix_api_key: str = os.environ.get("ZABBIX_API_KEY")
    zabbix_server: str = os.environ.get("ZABBIX_SERVER")
    proxy_name: str = os.environ.get("HOSTNAME")
    proxy_port: int = os.environ.get("ZABBIX_PROXY_PORT")
    proxy_offline: int = os.environ.get("PROXY_OFFLINE_BUFFER_HOURS")
    proxy_config_freq: int = os.environ.get("PROXY_CONFIG_FREQ")
    proxy_pollers: int = os.environ.get("PROXY_POLLERS")
    proxy_pollers_unreach: int = os.environ.get("PROXY_POLLERS_UNREACH")
    proxy_discoverers: int = os.environ.get("PROXY_DISCOVERERS")
    proxy_vmware_collectors: int = os.environ.get("PROXY_VMWARE_COLLECTORS")
    proxy_vmware_freq: int = os.environ.get("PROXY_VMWARE_FREQ")
    proxy_vmware_cache_mb: int = os.environ.get("PROXY_VMWARE_CACHE_MB")
    proxy_cache_mb: int = os.environ.get("PROXY_CACHE_MB")
    proxy_db_syncers: int = os.environ.get("PROXY_DB_SYNCERS")
    proxy_hist_cache_mb: int = os.environ.get("PROXY_HISTORY_CACHE_MB")
    proxy_hist_index_cache_mb: int = os.environ.get("PROXY_HISTORY_INDEX_CACHE_MB")
    proxy_psk_ident: str = os.environ.get("PROXY_HISTORY_INDEX_CACHE_MB")
    proxy_psk: str = os.environ.get("PROXY_PSK")

    # create a dict of the loaded env vars, to simplify loading into jinja
    vars_dict = {
        "frontend": zabbix_frontend_url,
        "key": zabbix_api_key,
        "server": zabbix_server,
        "name": proxy_name,
        "port": proxy_port,
        "offline": proxy_offline,
        "config_freq": proxy_config_freq,
        "pollers": proxy_pollers,
        "pollers_unreach": proxy_pollers_unreach,
        "discoverers": proxy_discoverers,
        "vmware_collectors": proxy_vmware_collectors,
        "vmware_freq": proxy_vmware_freq,
        "vmware_cache_mb": proxy_vmware_cache_mb,
        "proxy_cache_mb": proxy_cache_mb,
        "proxy_dbsyncers": proxy_db_syncers,
        "proxy_history_cache_mb": proxy_hist_cache_mb,
        "proxy_history_index_cache_mb": proxy_hist_index_cache_mb,
        "psk_ident": proxy_psk_ident,
        "proxy_psk": proxy_psk
        }

    # load the proxy jinja template from templates/
    file_loader = FileSystemLoader("templates")
    env = Environment(loader=file_loader)
    template_input = env.get_template("zabbix_proxy.conf.jinja")

    # render the config, using vars_dict as the only input
    rendered_config = template_input.render(vars_dict=vars_dict)

    # write the rendered config to a tempoary location (to be used outside python)
    with open("/tmp/.proxy-temp.conf", "a") as f:
        f.write(rendered_config)
    f.close()

    # log into the api using the provided API key
    zapi = ZabbixAPI(vars_dict["frontend"])
    zapi.login(api_token=vars_dict["key"])

    # create the proxy in zabbix via API
    res_create = zapi.proxy.create(
        host=vars_dict["name"],
        status=5,
        tls_psk_identity=vars_dict["psk_ident"],
        tls_psk=vars_dict["proxy_psk"],
        tls_accept=2
    )

main()