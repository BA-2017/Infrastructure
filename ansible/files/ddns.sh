#!/bin/bash

TOKEN="$DNSimpleToken"  # The API v2 OAuth token
ACCOUNT_ID="52675"        # Replace with your account ID
ZONE_ID="zhaw.tk"  # The zone ID is the name of the zone (or domain)
RECORD_ID="$DNSimpleRecordID"       # Replace with the Record ID
IP=`/sbin/ifconfig eth0 | grep 'inet addr' | cut -d: -f2 | awk '{print $1}'`

echo "`date '+%FT%T'`  Set DNS record for '`hostname`' to '$IP'"

curl -s -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -X "PATCH" \
     "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records/$RECORD_ID" \
     -d "{\"content\":\"$IP\"}" \

printf "\n"
