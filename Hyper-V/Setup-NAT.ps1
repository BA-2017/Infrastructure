# Create internal network switch
New-VMSwitch –SwitchName "NATSwitch" –SwitchType Internal

# Set IP address
New-NetIPAddress –IPAddress 172.21.21.1 -PrefixLength 24 -InterfaceAlias "vEthernet (NATSwitch)"

# Add NAT for Hyper-V internal switch
New-NetNat –Name 'MyNATnetwork' –InternalIPInterfaceAddressPrefix 172.21.21.0/24

# SSH port forwarding host:1022 => linux1(172.21.21.101):22
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.101 -Internalp 22 -Externalp 1022

# SSH port forwarding host:2022 => linux2(172.21.21.102):22
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.102 -Internalport 22 -ExternalPort 2022

# SSH port forwarding host:3022 => linux3(172.21.21.103):22
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.103 -Internalport 22 -ExternalPort 3022

# RDP port forwarding host:3399 => windows1(172.21.21.201):3389
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.201 -Internalport 3389 -ExternalPort 3399

# Kubernetes API-Server Port forwarding host:6443 => master(172.21.21.101):6443
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.101 -Internalp 6443 -Externalp 6443

# HTTP ingress to Kubernetes: host:80 => master:80
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.101 -Internalp 80 -Externalp 80

# HTTPS ingress to Kubernetes: host:443 => master:443
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.101 -Internalp 443 -Externalp 443

# Removes HTTPS ingress to Kubernetes
Remove-NetNatStaticMapping -NatName MyNATnetwork -StaticMappingID 6

# HTTPS port forwarding for AD FS: host:443 => windows1(172.21.21.201):443
Add-NetNatStaticMapping -NatName 'MyNATnetwork' -Protocol TCP -ExternalIPAddress 0.0.0.0 -InternalIPAddress 172.21.21.201 -Internalp 443 -Externalp 443
