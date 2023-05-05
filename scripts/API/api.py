from fastapi import FastAPI
from dotenv import load_dotenv
import os
from brownie import config, accounts, network,Contract, artist

load_dotenv()
app_add = os.getenv("app_address")
APP = Contract.from_abi('app',app_add,app.abi)

sys = FastAPI()



@sys.get('/')
def root():
    return {"app_add": app_add}

@sys.get('/artists')
def getlist():
    return {}

@sys.post('/createArtist')
def createArtist(name:str, address: str, data: str):
    artist = APP.CreateArtist(name,address,data)
    return {"artist":name, "address":address}
