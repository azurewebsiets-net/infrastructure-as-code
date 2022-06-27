Write-Host "Certificates" -ForegroundColor Cyan
kubectl get certificate -n azurewebsiets

Write-Host "`nCertificate Requests" -ForegroundColor Cyan
kubectl get certificaterequest -n azurewebsiets

$decision = $Host.UI.PromptForChoice("Info","Describe request?", @("&Yes","&No"), 0)
if ($decision -eq 0) {
    $name = kubectl get certificaterequest -n azurewebsiets -o name
    kubectl describe -n azurewebsiets $name
}