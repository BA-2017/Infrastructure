# Create internal network switch
New-VMSwitch –SwitchName "NATSwitch" –SwitchType Internal

# Set IP address
New-NetIPAddress –IPAddress 172.21.21.1 -PrefixLength 24 -InterfaceAlias "vEthernet (NATSwitch)"

# Add NAT for Hyper-V internal switch
New-NetNat –Name 'MyNATnetwork' –InternalIPInterfaceAddressPrefix 172.21.21.0/24

# Port forwarding host:1022 => linux1(172.21.21.):22
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.101 -InternalPort 22 -ExternalPort 1022

# Port forwarding host:2022 => linux2(172.21.21.102):22
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.102 -InternalPort 22 -ExternalPort 2022

# Port forwarding host:3022 => linux3(172.21.21.103):22
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.103 -InternalPort 22 -ExternalPort 3022

# Port forwarding host:3399 => windows1(172.21.21.201):3389
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.201 -InternalPort 3389 -ExternalPort 3399
