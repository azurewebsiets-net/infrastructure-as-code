Write-Host "Gathering Azure resource information" -ForegroundColor Cyan

$rg = "net.azurewebsiets";
$MIClientId = $(az aks show --name shared-cluster --resource-group shared-cluster --query identityProfile.kubeletidentity.clientId -o tsv)
$acc = az account show --output json | ConvertFrom-Json;
$tenantid = $acc.tenantId;
$subscriptionId = $acc.id;

$keys = az storage account keys list `
    --resource-group "net.azurewebsiets" --account-name "azurewebsiets" `
| ConvertFrom-Json;

Write-Host "Applying Helm config" -ForegroundColor Cyan

helm upgrade `
    --install `
    --namespace azurewebsiets `
    --create-namespace `
    --set "sub=$subscriptionId" `
    --set "rg=$rg" `
    --set "dns=azurewebsiets.net" `
    --set "clientId=$MIClientId" `
    --set "storageAccountKey=`"$($keys[0].value)`"" `
    "azurewebsiets" `
    "./"