# Data Ops with Azure Arc-enabled Data Services 
This repo contains sample scripts to help you build your own DevOps pipeline with the example from Arc-enabled data services for AD integrated SQL Managed instances. 

## Instructions

### Prerequisites 

#### 00 - deploy-cni-aks.sh

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

#### 00 - deploy-keytab-secret.sh

1. Download the script on the location that you are planning to use for the deployment

``` bash
curl --output deploy-keytab-secret https://raw.githubusercontent.com/cloudmelon/arcdata-ad-dataops/main/00-deploy-keytab-secret.sh
```

2. Make the script executable

``` bash
chmod +x deploy-keytab-secret
```

3. Run the script (make sure you are running with sudo)

``` bash
sudo ./deploy-keytab-secret
```

### Step 1 : Deploy Arc data controller - 01 - deploy-arc-data.sh

1. Download the script on the location that you are planning to use for the deployment

``` bash
curl --output deploy-arc-data.sh https://raw.githubusercontent.com/cloudmelon/arcdata-ad-dataops/main/01-deploy-arc-data.sh
```

2. Make the script executable

``` bash
chmod +x deploy-arc-data.sh
```

3. Run the script (make sure you are running with sudo)

``` bash
sudo ./deploy-arc-data.sh
```