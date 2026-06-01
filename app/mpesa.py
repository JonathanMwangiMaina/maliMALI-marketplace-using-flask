from flask import json, current_app
import requests
from requests.auth import HTTPBasicAuth
from datetime import datetime
import base64


class MpesaC2BCredential:
    @staticmethod
    def consumer_key():
        return current_app.config['MPESA_CONSUMER_KEY']

    @staticmethod
    def consumer_secret():
        return current_app.config['MPESA_CONSUMER_SECRET']

    @staticmethod
    def api_url():
        return current_app.config["MPESA_API_URL"] + current_app.config['MPESA_GRANT_TYPE']


class MpesaAccessToken:
    @staticmethod
    def get_token():
        response = requests.get(
            MpesaC2BCredential.api_url(),
            auth=HTTPBasicAuth(
                MpesaC2BCredential.consumer_key(),
                MpesaC2BCredential.consumer_secret()
            )
        )
        return response.json().get('access_token')

    @staticmethod
    def validated_mpesa_access_token():
        return MpesaAccessToken.get_token()
