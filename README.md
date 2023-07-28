# azure-container-app-with-hugging-face
Project: Create an Azure Container App with Databricks


What is Azure Container App

Serverless infrastructure for deployments. We can easily deploy with scaling a HuggingFace machine-learning model 

Azure Container App has the following features included:

* Create secrets
* Setup continuous deployment
* Revisions
* Monitoring

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
