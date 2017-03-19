# 1. Enable sharing for physical ethernet adapter
# 2. Add NAT for Hyper-V internal switch
New-NetNat –Name 'HyperV_NATnetwork' –InternalIPInterfaceAddressPrefix 192.168.137.0/24

# 3. Port forwarding host:1022 => linux1(192.168.137.18):22
Add-NetNatStaticMapping -NatName 'HyperV_NATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 192.168.137.18 -InternalPort 22 -ExternalPort 1022

# 4. Port forwarding host:2022 => linux2(192.168.137.95):22
Add-NetNatStaticMapping -NatName 'HyperV_NATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 192.168.137.95 -InternalPort 22 -ExternalPort 2022

# 5. Port forwarding host:3022 => linux3(192.168.137.213):22
Add-NetNatStaticMapping -NatName 'HyperV_NATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 192.168.137.213 -InternalPort 22 -ExternalPort 3022