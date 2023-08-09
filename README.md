# azure-container-app-with-hugging-face
Project: Create an Azure Container Application with a Hugging Face model for text generation

This project is one of the projects of the [*MLOps | Machine Learning Operations*](https://www.coursera.org/specializations/mlops-machine-learning-duke) course available on Coursera. I really recommend this course if you are interested in the MLOps field or Machine Learning Engineering using the most up-to-date tools and best practices.


## What is Azure Container App

Serverless infrastructure for deployments. We can easily deploy with scaling a HuggingFace machine-learning model 

Azure Container App has the following features included:

* Create secrets
* Setup continuous deployment
* Revisions
* Monitoring

### Auto-Scaling Azure Container App

We can use up to 300 applications replicas that'll be deployed in response to a trigger event. We can also use scale rules to determine the type of events that trigger scaling, i.e HTTP concurrent requests and Azure queue

## What is Azure Container Registry

Azure Container Registry (ACR) is a fully managed private Docker registry service provided by Microsoft Azure. It stores and manages container images. 

Some features of ACR:

* Geo-replication: scale across multiple regions
* Can automatically build, test, push, and deploy images to Azure with Azure Container Registry Tasks

## Use the Azure login action with a service principal secret

One requirement for this project is to create an Azure Service Principal that will permit connecting GitHub to Azure Portal

 1. Copy your subscription ID. You can find your in this [link](https://portal.azure.com/#view/Microsoft_Azure_Billing/SubscriptionsBlade)
 2. Open Azure Cloud Shell in the Azure portal or Azure CLI locally.
    ```bash
    AZURE_SUBSCRIPTION_ID=PASTE_YOUR_SUBSCRIPTION_ID_HERE
    az ad sp create-for-rbac --name "CICD" --role contributor --scopes /subscriptions/$AZURE_SUBSCRIPTION_ID  --json-auth
    ```
3. Copy the JSON object and save it for now

For more information check this [link](https://learn.microsoft.com/en-us/azure/developer/github/connect-from-azure?tabs=azure-portal%2Cwindows)
   

## Creating a container registry

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/267ee9f9-4230-4695-ae44-1ef7c977840b" width=50% height=50%>

1. Create a new resource group and give a name to the registry 

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/2195272a-803b-4504-95f9-cd59f995122f" width=50% height=50%>

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/c67be428-2cba-43ae-9a2a-972701768ab0" width=50% height=50%>

2. Go to resource and select the `Access keys` tab
   
<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/37d64e2a-e4ef-4f61-bf52-163afdd6b43b" width=50% height=50%>

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/905f9779-7bf2-4342-acad-b0a9b33d7f0d" width=50% height=50%>

3. Enable the `Admin user` and copy one of the available passwords
   
<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/10fe4925-d6f1-4c67-94c6-fe86f5768707" width=50% height=50%>

4. Copy the registry repository name as we will use it in the GitHub Actions Yaml file
   
<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/242e5f9f-c795-4ff5-8997-840d576ed450" width=50% height=50%>

Below you can check your container image name. We need to use this name in the GitHub Action Yaml file.

```
az containerapp update -n ${{ env.AZURE_CONTAINER_APP_NAME }} -g ${{ env.AZURE_GROUP_NAME }} --image textgeneration.azurecr.io/mathewsrc/azure-container-app-with-hugging-face:${{ github.sha }}
```

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/bbb02ce8-ad90-42bf-ae59-9432f4ea875b" width=50% height=50%>



## GitHub Actions secrets

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/7283e870-98d9-445a-be2e-950ee0c986f2" width=50% height=50%>

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/cb36d85d-94c4-4cd1-baf6-619c783da21b" width=50% height=50%>

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/839d0947-e5e7-400c-bfa8-97c45d625bcb" width=50% height=50%>

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/931e998c-21d4-46aa-818b-50feb05d64cd" width=50% height=50%>

We need to create a last secret for the Azure JSON object that we saved before. I named my secret as AZURE_CREDENTIALS.

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/0b978432-17b9-4c99-aa83-447b2b7cccb4" width=50% height=50%>

Then we can use the AZURE_CREDENTIALS, PASSWORD and USERNAME in GitHub Actions Yaml file:
```Yaml
steps:
      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}
```

```Yaml
with:
          registry: textgeneration.azurecr.io # Registry, i.e Docker Registry (ghcr.io), Azure Registry (azurecr.io)
          username: ${{ secrets.ACR_USERNAME }}
          password: ${{ secrets.ACR_PASSWORD }}
```


## Creating a new container app

In order to create the container we need to follow the steps below:
   1. Create a new resource group
   2. Give the container app a global unique name
   3. Choose a Region (for me Brazil is the closest region)
      
<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/3fffd8e8-3ed4-4997-948e-9e8581370d02" width=50% height=50%><br/>

Click on `create` button

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/7a39590b-326a-4c4f-bc94-cdf11e1ade36" width=50% height=50%>

If everything works fine you will see this output. Now click on the `Got to resource` button

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/d8a198cd-e18f-4558-ae94-a5e8f10635ad" width=50% height=50%>


## Setup ingress

We need now to setup ingress for our container as we are using a FAST API app that need a HTTP communication

1. Go to `ingress` tab
2. Change the `Target port` to the same port as the one in the Dockerfile EXPOSE 8000 (or any port you choose)

   <img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/7212a5f1-6d78-4e8c-ad04-15fba7be37ec" width=50% height=50%>

3. Click on `save` button

## Edit and deploy container 

1. Click on `edit and deploy`
   
   <img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/a2759e24-c883-4006-9eb0-97d985801a12" width=50% height=50%>

2. Select the container we just created
   
   <img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/2add5849-7557-4ac4-8a21-1e01f33fbf76" width=50% height=50%>

3. Change CPU and RAM settings and click on `save`

   <img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/54a8b9ee-6f6d-4b2a-b780-105cccf36bd4" width=50% height=50%>

if you go back to the containers tab you can see that the settings of the container have changed

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/347489ef-3cc7-4710-9c10-b6ac3fc470b2" width=50% height=50%>

After we set up the container app we can update the GitHub Actions Yaml file with the container app name and group name:
```Yaml
env:
  AZURE_CONTAINER_APP_NAME: textgeneration
  AZURE_GROUP_NAME: huggingface
```

```Yaml
 az config set extension.use_dynamic_install=yes_without_prompt
            az containerapp registry set -n ${{ env.AZURE_CONTAINER_APP_NAME }} -g ${{ env.AZURE_GROUP_NAME }} --server textgeneration.azurecr.io --username ${{ secrets.ACR_USERNAME }} --password ${{ secrets.ACR_PASSWORD }}
            az containerapp update -n ${{ env.AZURE_CONTAINER_APP_NAME }} -g ${{ env.AZURE_GROUP_NAME }} --cpu 2 --memory 4Gi
            az containerapp update -n ${{ env.AZURE_CONTAINER_APP_NAME }} -g ${{ env.AZURE_GROUP_NAME }} --image textgeneration.azurecr.io/mathewsrc/azure-container-app-with-hugging-face:${{ github.sha }}
```

## GitHub Actions manual trigger

We can disable GitHub Actions auto CI/CD by modifying the Yaml file

```Yaml
on:
  # Automatically trigger it when detected changes in repo. Remove comments to enable
  #push:
  #  branches: 
  #    [ main ]

  # Allow manual trigger 
  workflow_dispatch:
```

### Then we can go to the GitHub Actions tab and trigger our app CI/CD workflow

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/f23bf1fd-839d-4140-800f-b9667fd2c2d8" width=50% height=50%>

Running

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/9045cc2b-7872-4ae6-b119-585737171161" width=50% height=50%>

Complete

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/496ddecc-515e-4e08-9b0b-9706c5794d11" width=50% height=50%>

Then we can go back to Azure Container App and open the application URL

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/ae4d06e0-d518-4a96-bf2f-4eebc18347e1" width=50% height=50%>

### App Home

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/82e59856-4f1b-4740-99cb-f793360b395f" width=50% height=50%>

### POST request

First, add docs at the end of the URL to open FASTAPI

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/74d82fe2-ce10-4ff3-b702-b84927d122e1" width=50% height=50%>

Finally, we can call the Hugging Face model

<img src="https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/de1f8609-b15c-4db8-8784-648bfbf8ecc7" width=50% height=50%>

Result

![generate_result](https://github.com/mathewsrc/azure-container-app-with-hugging-face/assets/94936606/676502e3-cb85-46df-8ab2-46a7d9d59a85)


