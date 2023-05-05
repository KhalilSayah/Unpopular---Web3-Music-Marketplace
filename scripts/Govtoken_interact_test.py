from brownie import config, accounts, network, Contract, GovToken
from web3 import Web3


Token_add = "0xABaBf7fF8D3DFAF7F86d89D62C84F07231065580"
system = Contract.from_abi('GovToken', Token_add, GovToken.abi)


Client = "0xDe56Ad7e9B29ec2EB2F410336F9b932489Ef00af"
account = accounts.add(config["wallets"]["from_key"])
Public_key = "0xE05c9D0312985bF30590BB1570999FEe44819998"



def transaction():

    amount = int(50 * 10**system.decimals())

    

    system.transfer(Client,amount,{"from":account})

    pass






def main():

    tr = transaction()
    print("tr")
    