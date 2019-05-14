$aks = "azuredevops2019"

# Query latest AKS Kubernetes version
$latestK8sVersion=$(az aks get-versions -l $location --query 'orchestrators[-1].orchestratorVersion' -o tsv)

Write-Output $latestK8sVersion

# Setup of the AKS cluster
az aks create -l $location -n $aks -g $rg --generate-ssh-keys -k $latestK8sVersion

# Once created (the creation could take ~10 min), get the credentials to interact with your AKS cluster
az aks get-credentials -n $aks -g $rg

# Setup tiller for Helm
kubectl create serviceaccount tiller --namespace kube-system
kubectl create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller

# Setup the azure-devops-demo K8s namespace, we will deploy later some apps into it
kubectl create namespace azure-devops-demo
kubectl create clusterrolebinding default-view --clusterrole=view --serviceaccount=azuredevopsdemo:default