#!/bin/bash
#Define a set of environment variables to be used in resource creations.
#

read -p "Your Azure Subscription: " subscription
echo
read -p "Your Resource Group Name: " resourcegroup
echo
read -p "In which region you're deploying: " region
echo


#Define a set of environment variables to be used in resource creations.
export SUBID=$subscription

export REGION_NAME=$region
export RESOURCE_GROUP=$resourcegroup
export KUBERNETES_VERSION=$version


az arcdata dc create --profile-name azure-arc-aks-default-storage \
                     --k8s-namespace arc-ops \
                     --name arcopsctl \
                     --subscription $SUBID \
                     --resource-group $RESOURCE_GROUP \
                     --location $REGION_NAME \
                     --connectivity-mode indirect \
                     --use-k8s




