# Infrastructure

Infrastructure related stuff

## Setup a new linux VM
1. Install Ubuntu server 16.04 (C:\Disk-Images\ubuntu-16.04.2-server-amd64.iso):
    1. Set hostname 'linuxN' (i.e.: linux1, linux2, linux3)
    1. Setup LVM
    1. Add user
    1. Install OpenSSH server
    1. Set root password: `sudo passwd`
    1. Install python 2.7: `sudo apt install python`
1. Configure NAT forwarding on Hyper-V host (see Setup-NAT.ps1): hyperv.zhaw.tk:N022 => VM:22
1. Add ssh keys to host: `ssh-copy-id -p N022 hyperv.zhaw.tk`
1. Test ansible connectivity: `ansible linux -m ping -i hosts`
1. Run ansible playbook: `ansible-playbook -i hosts basic_setup.yml -K --extra-vars "DNSimpleToken=TOKEN"`

## Run arbitrary command on linux VMs
Using ansible: `ansible linux -m shell -a "echo command" -i hosts [--become -K]`

## SSH connectivity to linux VM
For every VM a static port mapping is configured for the NAT. The SSH port is prefixed with the VM number (n022) i.e. linux1:
`ssh user@hyperv.zhaw.tk -p 1022`