from brownie import accounts,network, GovToken,config

account = accounts.add(config["wallets"]["from_key"])

def deploy():
    deployement = GovToken.deploy({"from" : account})


def main():
    deploy()