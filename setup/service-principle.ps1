# Grant the AKS-generated service principal pull access to our ACR, the AKS cluster will be able to pull images of our ACR
$CLIENT_ID=$(az aks show -g $rg -n $aks --query "servicePrincipalProfile.clientId" -o tsv)
$ACR_ID=$(az acr show -n $acr -g $rg --query "id" -o tsv)
az role assignment create --assignee $CLIENT_ID --role acrpull --scope $ACR_ID

# Create a specific Service Principal for our Azure DevOps pipelines to be able to push and pull images and charts of our ACR
$registryPassword=$(az ad sp create-for-rbac -n $acr-push --scopes $ACR_ID --role acrpush --query password -o tsv)
# Important note: you will need this registryPassword value later 
Write-Output $registryPassword