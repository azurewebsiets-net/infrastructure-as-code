kubectl kustomize --enable-helm | kubectl delete -f -
kubectl delete ns external-dns-azurewebsiets