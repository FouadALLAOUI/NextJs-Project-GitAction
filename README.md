This is a starter template for [Learn Next.js](https://nextjs.org/learn).


~~~bash
$RESOURCE_GROUP_NAME = "<Name of Resource Group>"
$LOCATION = "<Location of Resource Group>"

$APP_SERVICE_PLAN_NAME = "<Name of App Service Plan>"
$APP_SERVICE_PLAN_SKU = "<SKU of App Service Plan>"

$WEB_APP_NAME = "<Name of Web App>"
$WEB_APP_RUNTIME = "NODE:18-lts" # This is not the latest version of Node, but it is the version supported by Azure App Service at the time of writing this article.
~~~

~~~bash
az group create `
    --name $RESOURCE_GROUP_NAME `
    --location $LOCATION
~~~
~~~bash
az appservice plan create `
    --resource-group $RESOURCE_GROUP_NAME `
    --location $LOCATION `
    --is-linux `
    --name $APP_SERVICE_PLAN_NAME `
    --sku $APP_SERVICE_PLAN_SKU
~~~
~~~bash
az webapp create `
    --resource-group $RESOURCE_GROUP_NAME `
    --plan $APP_SERVICE_PLAN_NAME `
    --name $WEB_APP_NAME `
    --https-only $true `
    --runtime $WEB_APP_RUNTIME `
    --assign-identity [system]
~~~

~~~bash
$WEB_APP_NAME = "<Name of Web App>"
$RESOURCE_GROUP_NAME = "<Name of Resource Group>"

az webapp config set `
    --resource-group $RESOURCE_GROUP_NAME `
    --name $WEB_APP_NAME `
    --startup-file "node .next/standalone/server.js"
~~~

~~~bash
name: Deploy to Azure

on:
  push:
    branches: ["main"]

  workflow_dispatch:

permissions:
  id-token: write # This is required for requesting the JWT
  contents: read # This is required for actions/checkout

jobs:
  build:
    name: Build
    runs-on: ubuntu-latest
    steps:
      - name: Checkout # Checked out your repository
        uses: actions/checkout@v3

      - name: Setup Node # Installs NodeJS 18
        uses: actions/setup-node@v3
        with:
          node-version: "18"

      - name: Install dependencies # Installs your app dependencies
        run: |
          npm install

      - name: 'Login to Azure Subscription' # This is required for OIDC authentication to Azure
        uses: azure/login@v1
        with:
            client-id: ${{ secrets.AZURE_CLIENT_ID }}
            tenant-id: ${{ secrets.AZURE_TENANT_ID }}
            subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
~~~
