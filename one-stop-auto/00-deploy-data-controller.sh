#!/bin/bash
#Define a set of environment variables to be used in resource creations.
export DOCKER_USERNAME="arcdata-readonly-adhoc"
export DOCKER_PASSWORD="jir/doABaNQbBxDMNZWesvGzxPsWky9M"

export SUBID="182c901a-129a-4f5d-86e4-cc6b294590a2"
export REGION_NAME=eastus
export RESOURCE_GROUP=melqin-arcops-rg
export AZDATA_LOGSUI_USERNAME=arcuser
export AZDATA_LOGSUI_PASSWORD=arc@123!!
export AZDATA_METRICSUI_USERNAME=arcuser
export AZDATA_METRICSUI_PASSWORD=arc@123!!


az arcdata dc config init --source azure-arc-kubeadm --path ./arc-ad-auto-aks

az arcdata dc config replace --path arc-ad-auto-aks/control.json --json-values ".spec.docker.repository=arcdata-p-daily"

az arcdata dc config replace --path arc-ad-auto-aks/control.json --json-values ".spec.docker.imageTag=v1.5.0_2022-03-26_master_51c82cae7"

az arcdata dc config replace --path arc-ad-auto-aks/control.json --json-values ".spec.docker.registry=arcdata.azurecr.io"

az arcdata dc config replace --path arc-ad-auto-aks/control.json --json-values ".spec.infrastructure=azure"


az extension add -s C:/BugBash/arcdata-1.3.0.20220325.2-py2.py3-none-any.whl -y 

az arcdata dc create --profile-name arc-ad-auto-aks \
                     --k8s-namespace arc-auto-ad \
                     --name arcadctl \
                     --subscription $SUBID \
                     --resource-group $RESOURCE_GROUP \
                     --location $REGION_NAME \
                     --connectivity-mode indirect \
                     --use-k8s


