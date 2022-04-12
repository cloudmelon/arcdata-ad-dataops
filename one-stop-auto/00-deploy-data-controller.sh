#!/bin/bash
#Define a set of environment variables to be used in resource creations.


export SUBID="< your sub id >"
export REGION_NAME=eastus
export RESOURCE_GROUP=your-arcops-rg
export AZDATA_LOGSUI_USERNAME=arcuser
export AZDATA_LOGSUI_PASSWORD=arc@123!!
export AZDATA_METRICSUI_USERNAME=arcuser
export AZDATA_METRICSUI_PASSWORD=arc@123!!


az arcdata dc create --profile-name arc-ad-auto-aks \
                     --k8s-namespace arc-auto-ad \
                     --name arcadctl \
                     --subscription $SUBID \
                     --resource-group $RESOURCE_GROUP \
                     --location $REGION_NAME \
                     --connectivity-mode indirect \
                     --use-k8s


