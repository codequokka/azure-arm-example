Azure ARM Examples
====================

Deploy the vnet, nsg, bation, etc.
---------------------------------
```
$ ./deploy-arm-templates.sh base

# Copy ssh keys to the bastion
$ bastion_vm_pip=$(az network public-ip list | jq -r '.[] | select(.name == "bastion-vm-pip") | .ipAddress')
$ scp -i .ssh/id_rsa .ssh/id_rsa* kitsuneinu@${bastion_vm_pip}:/home/kitsuneinu/.ssh/
```

Deploy the virtual machines.
----------------------------
```
# Deploying the single virtual machine
$ ./deploy.sh single

# Deploying the multi virtual machines with availabilty sets
$ ./deploy.sh multi-as

# Deploying the multi virtual machines with virtual machine scale sets
$ ./deploy.sh multi-vmss

# Deploying the multi virtual machines with availabilty zones
$ ./deploy.sh multi-zone

# Deploying the multi virtual machines with virtual machine scale sets and availabilty zones
$ ./deploy.sh multi-zone-vmss
```

Deploy the nginx to deployed virtual machine.
--------------------------------------------
```
$ cd ansible
$ ansible-playbook playbooks/setup-nginx.yml
```

memo
----
```
$ ssh -o ProxyCommand='ssh -i .ssh/id_rsa -W %h:%p kitsuneinu@bastion-vm.japaneast.cloudapp.azure.com' -i .ssh/id_rsa kitsuneinu@10.0.1.4

$ ansible-playbook setup-nginx.yml
❯ ssh -o ProxyCommand='ssh -i ../.ssh/id_rsa -W %h:%p kitsuneinu@bastion-vm.japaneast.cloudapp.azure.com' -i ../.ssh/id_rsa -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null kitsuneinu@10.0.1.4
```
