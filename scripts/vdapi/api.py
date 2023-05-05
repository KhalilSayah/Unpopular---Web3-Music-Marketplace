import requests
import json
from brownie import config

file = "sample.mp4"
api_key = "srvacc_wz6wmegn2wca1anyenz5ck80y"
api_secret_key = "w1750bi0hca7m60bm5xfz8ft7ds8yzfi"


def pre_signed_url ():
    url = "https://api.thetavideoapi.com/upload"
    headers = {
        'x-tva-sa-id': api_key,
        'x-tva-sa-secret': api_secret_key
    }
    r = requests.post(url,headers=headers)
    response = r.json()
    id = response["body"]["uploads"][0]["id"]
    presigned_url = response["body"]["uploads"][0]["presigned_url"]
    return id,presigned_url

def upload(presigned_url,file):

    url = presigned_url
    headers = {
    'Content-Type': 'application/octet-stream'
    }
    body = file

    r = requests.put(url,headers=headers, data=body)
    response = r
    return response

def transcode(id):

    url = "https://api.thetavideoapi.com/video"
    headers = {
    'x-tva-sa-id': api_key,
    'x-tva-sa-secret': api_secret_key,
    'Content-Type': 'application/json'
    }
    body = json.dumps({"source_upload_id":id,"playback_policy":"public"})
    r = requests.post(url,headers=headers, data=body)
    response = r.json()
    return response


id,presigned_url = pre_signed_url()
upload(presigned_url,file)

transcode(id)



