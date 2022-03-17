# Data Ops with Azure Arc-enabled Data Services 
This repo contains sample scripts to help you build your own DevOps pipeline with the example from Arc-enabled data services for AD integrated SQL Managed instances. 

## Instructions

### 00 - deploy-cni-aks.sh

1. Download the script on the location that you are planning to use for the deployment

``` bash
curl --output deploy-cni-aks.sh https://raw.githubusercontent.com/cloudmelon/arcdata-ad-dataops/main/00-deploy-cni-aks.sh
```

2. Make the script executable

``` bash
chmod +x deploy-cni-aks.sh
```

3. Run the script (make sure you are running with sudo)

``` bash
sudo ./deploy-cni-aks.sh
```