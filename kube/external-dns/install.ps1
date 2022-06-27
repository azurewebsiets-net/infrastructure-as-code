$rg = "net.azurewebsiets";
$MIClientId=$(az aks show --name shared-cluster --resource-group shared-cluster --query identityProfile.kubeletidentity.clientId -o tsv)
$acc = az account show --output json | ConvertFrom-Json;
$tenantid = $acc.tenantId;
$subscriptionId = $acc.id;

helm upgrade `
    --install external-dns-azurewebsiets bitnami/external-dns `
    --namespace external-dns-azurewebsiets `
    --create-namespace `
    --set provider=azure `
    --set txtOwnerId=clusterNamehelm `
    --set policy=sync `
    --set azure.resourceGroup=$rg `
    --set azure.tenantId=$tenantid `
    --set azure.subscriptionId=$subscriptionid `
    --set azure.useManagedIdentityExtension=true `
    --set azure.userAssignedIdentityID=$MIClientId