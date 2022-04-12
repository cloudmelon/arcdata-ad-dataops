#!/bin/bash
#Define a set of environment variables to be used in resource creations.

export SUBID="<your sub id >"
export REGION_NAME=westeurope
export RESOURCE_GROUP=mel-arcops-rg
export AZDATA_LOGSUI_USERNAME=arcuser
export AZDATA_LOGSUI_PASSWORD=arcuser@123
export AZDATA_METRICSUI_USERNAME=arcuser
export AZDATA_METRICSUI_PASSWORD=arcuser@123


az arcdata dc create --profile-name azure-arc-aks-default-storage \
                     --k8s-namespace arc-ops \
                     --name arcopsctl \
                     --subscription $SUBID \
                     --resource-group $RESOURCE_GROUP \
                     --location $REGION_NAME \
                     --connectivity-mode indirect \
                     --use-k8s


#az arcdata dc create --name arc-dc1 --resource-group my-resource-group --location eastasia --connectivity-mode direct --profile-name azure-arc-aks-premium-storage  --auto-upload-logs true --auto-upload-metrics true --custom-location mycustomlocation --storage-class mystorageclass

