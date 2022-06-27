$rg = "net.azurewebsiets";
$MIClientId=$(az aks show --name shared-cluster --resource-group shared-cluster --query identityProfile.kubeletidentity.clientId -o tsv)
$acc = az account show --output json | ConvertFrom-Json;
$tenantid = $acc.tenantId;
$subscriptionId = $acc.id;

helm upgrade `
    --install `
    --namespace azurewebsiets `
    --create-namespace `
    --set "sub=$subscriptionId" `
    --set "rg=$rg" `
    --set "dns=azurewebsiets.net" `
    --set "clientId=$MIClientId" `
    "azurewebsiets" `
    "./"