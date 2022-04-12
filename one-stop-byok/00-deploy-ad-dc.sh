#!/bin/bash
#Define a set of environment variables to be used in resource creations.
#

export Location=westeurope
export ResourceGroupName=melqin-arcadops-rg
export NetworkSecurityGroup=arc-nsg
export VNetName=Arc-VNet
export VNetAddress=10.0.0.0/16
export SubnetName1=mnt-subnet
export SubnetName2=aks-subnet
export SubnetAddress=10.0.10.0/24
export VMSize=Standard_DS3_v2
export DataDiskSize=20
export AdminUsername=arcadmin
export AdminPassword=arcadmin@123
export DomainController=AZDC
export DC_IP=10.0.10.10

# Create a resource group.
az group create --name $ResourceGroupName \
                --location $Location

# Create a network security group
az network nsg create --name $NetworkSecurityGroup \
                      --resource-group $ResourceGroupName \
                      --location $Location

# Create a network security group rule for port 3389.
az network nsg rule create --name PermitRDP \
                           --nsg-name $NetworkSecurityGroup \
                           --priority 1000 \
                           --resource-group $ResourceGroupName \
                           --access Allow \
                           --source-address-prefixes "*" \
                           --source-port-ranges "*" \
                           --direction Inbound \
                           --destination-port-ranges 3389

# Create a virtual network.
az network vnet create --name $VNetName \
                       --resource-group $ResourceGroupName \
                       --address-prefixes $VNetAddress \
                       --location $Location \

# Create a subnet
az network vnet subnet create --address-prefix $SubnetAddress \
                              --name $SubnetName \
                              --resource-group $ResourceGroupName \
                              --vnet-name $SubnetName1 \
                              --network-security-group $NetworkSecurityGroup


# Create two virtual machines.
az vm create \
    --resource-group $ResourceGroupName \
    --name $DomainController \
    --size $VMSize \
    --image Win2019Datacenter \
    --admin-username $AdminUsername \
    --admin-password $AdminPassword \
    --data-disk-sizes-gb $DataDiskSize \
    --data-disk-caching None \
    --nsg $NetworkSecurityGroup \
    --public-ip-sku Standard \
    --private-ip-address $DC_IP \
    --no-wait

# Change private IP addresses to static ip address

# To get ipconfig name : az network nic ip-config list
  az network nic ip-config update \
    --name ipconfigAZDC01 \
    --resource-group melqin-arcad-rg \
    --nic-name AZDC01VMNic \
    --private-ip-address 10.10.10.11


