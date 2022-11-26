Write-Host "Certificates" -ForegroundColor Cyan
kubectl get certificate -n azurewebsiets -o wide

Write-Host "`nCertificate Requests" -ForegroundColor Cyan
kubectl get certificaterequest -n azurewebsiets -o wide

Write-Host "`nOrders" -ForegroundColor Cyan
kubectl get order -n azurewebsiets -o wide

Write-Host "`nChallenges" -ForegroundColor Cyan
kubectl get challenge -n azurewebsiets -o wide

$decision = $Host.UI.PromptForChoice("Describe resources","Describe a resource?", @("&Cert","&Request", "&Order", "Cha&llenge"), 0)
if ($decision -eq 0)
{
    $name = kubectl get certificate -n azurewebsiets -o name
    kubectl describe -n azurewebsiets $name
}
elseif ($decision -eq 1)
{
    $name = kubectl get certificaterequest -n azurewebsiets -o name
    kubectl describe -n azurewebsiets $name
}
elseif ($decision -eq 2)
{
    $name = kubectl get order -n azurewebsiets -o name
    kubectl describe -n azurewebsiets $name
}
elseif ($decision -eq 3)
{
    $name = kubectl get challenge -n azurewebsiets -o name
    kubectl describe -n azurewebsiets $name
}