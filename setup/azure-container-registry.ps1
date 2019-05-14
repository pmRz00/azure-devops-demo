# Show all european regions
az account list-locations | Select-String -Pattern eu

$location = "westeurope"
$rg = "devops-demo"
$acr = "h"

# Create a resource group $rg on a specific location $location (for example eastus) which will contain the Azure services we need 
az group create -l $location -n $rg
# Create an ACR registry $acr
az acr create -n $acr -g $rg -l $location --sku Basic