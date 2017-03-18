#!/bin/bash

TOKEN="4BxFCzfeFBv2LvMWPv1o4YT8ew38fR87"  # The API v2 OAuth token
ACCOUNT_ID="52675"        # Replace with your account ID
ZONE_ID="zhaw.tk"  # The zone ID is the name of the zone (or domain)
RECORD_ID="{RECORD_ID}"       # Replace with the Record ID
IP=`curl -s http://icanhazip.com/`

curl -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -X "PATCH" \
     -i "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records/$RECORD_ID" \
     -d "{\"content\":\"$IP\"}"
