az extension add --name azure-devops
az extension show --name azure-devops
az devops configure --defaults organization=https://dev.azure.com/tostille/
az devops project create --name "multi-stage-builds"
az repos import create --git-source-url "https://github.com/tpstiller/azure-devops-demo.git" --project "multi-stage-builds" --repository "azure-devops-demo"
