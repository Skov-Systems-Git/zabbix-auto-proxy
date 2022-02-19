import configparser, os
cfg = configparser.ConfigParser()
cfg.read('config.ini')
print(cfg.get('System', 'conda_location', vars=os.environ))
