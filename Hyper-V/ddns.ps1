echo $PSScriptRoot

$TOKEN="SECRET_TOKEN"  # The API v2 OAuth token
$ACCOUNT_ID="52675"        # Account ID
$ZONE_ID="zhaw.tk"  # The zone ID is the name of the zone (or domain)
$RECORD_ID="11248179"       # Record ID
$IP = Get-NetIPAddress -InterfaceAlias 'vEthernet (Intel(R) Ethernet Connection I217-LM - Virtual Switch)' -AddressFamily IPv4 | Select IPAddress -First 1
$IP = $IP.IPAddress.ToString()
$DATE = date
$HOSTNAME = hostname
$LOGFILE = "$PSCommandPath.log"

echo "$DATE  Set DNS record for '$hostname' to '$IP'"

$uri = "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records/$RECORD_ID"

$headers = @{
  Authorization = "Bearer $TOKEN"
  Accept        = "application/json"
  "Content-Type"  = "application/json"
}

$json = @{
  content = "$IP"
} |ConvertTo-Json

Invoke-WebRequest -Uri $uri -Body $json -Headers $headers -Method Patch | Out-File $LOGFILE
