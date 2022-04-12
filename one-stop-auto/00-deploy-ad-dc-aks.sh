#!/bin/bash
#Define a set of environment variables to be used in resource creations.
#

export Location=westeurope
export ResourceGroupName=your-arcadops-rg
export NetworkSecurityGroup=arc-nsg
export VNetName=arc-vnet
export VNetAddress=10.0.0.0/16
export SubnetName1=mnt-subnet
export SubnetName2=aks-subnet
export VMSize=Standard_DS8_v3
export DataDiskSize=20
export AdminUsername=arcadmin
export AdminPassword=arcadmin@123
export DomainController=AZDC
export DC_IP=10.0.10.10
export AKS_NAME=arcopsaks 

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
az network vnet subnet create --address-prefix 10.0.10.0/24 \
                              --name $SubnetName1 \
                              --resource-group $ResourceGroupName \
                              --vnet-name $VNetName \
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
    --name ipconfigAZDC \
    --resource-group $ResourceGroupName \
    --nic-name AZDCVMNic \
    --private-ip-address $DC_IP

# Change DNS resolution to use dc's NIC for domaining join client
DNS_IP=$(az vm show -g $ResourceGroupName -n $DomainController --query privateIps -d --out tsv)

az network vnet update -g $ResourceGroupName -n $VNetName --dns-servers $DNS_IP


az network vnet subnet create --address-prefix 10.0.20.0/24 \
                              --name $SubnetName2 \
                              --resource-group $ResourceGroupName \
                              --vnet-name $VNetName 

SUBNET_ID=$(az network vnet subnet show \
    --resource-group $ResourceGroupName \
    --vnet-name $VNetName \
    --name $SubnetName2 \
    --query id -o tsv)
 

#Create AKS Cluster
az aks create \
    --resource-group $ResourceGroupName \
    --name $AKS_NAME \
    --load-balancer-sku standard \
    --network-plugin azure \
    --vnet-subnet-id $SUBNET_ID \
    --docker-bridge-address 172.17.0.1/16 \
    --dns-service-ip 10.0.30.10 \
    --service-cidr 10.0.30.0/24 \
    --node-vm-size Standard_D8s_v3 \
    --node-count 8 \
    --generate-ssh-keys


    
#Create AKS Cluster
#az aks create --resource-group melqin-arcadops-rg --name arcopsaks --load-balancer-sku standard --network-plugin azure --vnet-subnet-id "/subscriptions/182c901a-129a-4f5d-86e4-cc6b294590a2/resourceGroups/melqin-arcadops-rg/providers/Microsoft.Network/virtualNetworks/arc-vnet/subnets/aks-subnet" --docker-bridge-address 172.17.0.1/16 --dns-service-ip 10.0.30.10 --service-cidr 10.0.30.0/24 --node-vm-size Standard_D8_v3 --node-count 8 --generate-ssh-keys

az aks get-credentials -g $ResourceGroupName -n $AKS_NAME