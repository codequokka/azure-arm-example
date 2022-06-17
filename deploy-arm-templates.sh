#!/bin/bash

location='japaneast'
templates_dir='arm/templates'

if [ "$#" != 1 ]; then
  echo "$0 <deploy target>"
  exit 1
fi

target="$1"
resource_group="arm-example-${target}-rg"

if [ $target == 'base' ]; then
  echo '# -----------------------------------------------'
  echo "# Deploying the resource group to $resource_group"
  echo '# -----------------------------------------------'
  az deployment sub create --location $location --template-file ${templates_dir}/${target}/resource-group.json
  
  echo '# --------------------------------------------------------'
  echo "# Deploying the network security groups to $resource_group"
  echo '# --------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/network-security-groups.json
  
  echo '# ------------------------------------------------'
  echo "# Deploying the virtual network to $resource_group"
  echo '# ------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/virtual-network.json
  
  echo '# -------------------------------------------------'
  echo "# Deploying the storage accounts to $resource_group"
  echo '# -------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/storage-accounts.json
  
  echo '# --------------------------------------------------------'
  echo "# Deploying the bastion virtual machine to $resource_group"
  echo '# --------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/bastion.json

  # echo '# Deploying bastionHosts'
  # az deployment group create --resource-group $resource_group --template-file ${templates_dir}/bastionHosts.json
elif [ $target == 'single' ]; then
  echo '# -----------------------------------------------'
  echo "# Deploying the resource group to $resource_group"
  echo '# -----------------------------------------------'
  az deployment sub create --location $location --template-file ${templates_dir}/${target}/resource-group.json

  echo '# -------------------------------------------------------'
  echo "# Deploying the single virtual machine to $resource_group"
  echo '# -------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/virtual-machines.json
elif [ $target == 'multi-as' ]; then
  echo '# -----------------------------------------------'
  echo "# Deploying the resource group to $resource_group"
  echo '# -----------------------------------------------'
  az deployment sub create --location $location --template-file ${templates_dir}/${target}/resource-group.json

  echo '# -----------------------------------------------------------------------------'
  echo "# Deploying the multi virtual machines with availabilty sets to $resource_group"
  echo '# -----------------------------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/virtual-machines.json
elif [ $1 == 'multi-vmss' ]; then
  echo '# -----------------------------------------------'
  echo "# Deploying the resource group to $resource_group"
  echo '# -----------------------------------------------'
  az deployment sub create --location $location --template-file ${templates_dir}/${target}/resource-group.json

  echo '# ---------------------------------------------------------------------------------------'
  echo "# Deploying the multi virtual machines with virtual machine scale sets to $resource_group"
  echo '# ---------------------------------------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/virtual-machines.json
elif [ $1 == 'multi-zone' ]; then
  echo '# -----------------------------------------------'
  echo "# Deploying the resource group to $resource_group"
  echo '# -----------------------------------------------'
  az deployment sub create --location $location --template-file ${templates_dir}/${target}/resource-group.json

  echo '# ------------------------------------------------------------------------------'
  echo "# Deploying the multi virtual machines with availabilty zones to $resource_group"
  echo '# ------------------------------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/virtual-machines.json
elif [ $1 == 'multi-zone-vmss' ]; then
  echo '# -----------------------------------------------'
  echo "# Deploying the resource group to $resource_group"
  echo '# -----------------------------------------------'
  az deployment sub create --location $location --template-file ${templates_dir}/${target}/resource-group.json

  echo '# -------------------------------------------------------------------------------------------------------------'
  echo "# Deploying the multi virtual machines with virtual machine scale sets and availabilty zones to $resource_group"
  echo '# -------------------------------------------------------------------------------------------------------------'
  az deployment group create --resource-group $resource_group --template-file ${templates_dir}/${target}/virtual-machines.json
else
  echo '# Do nothing'
fi