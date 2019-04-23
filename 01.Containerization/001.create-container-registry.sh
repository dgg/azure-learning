##>
az group create -l northeurope -n dgg-RG
##>
az acr create -n dggRegistry -g dgg-RG --sku Basic
##>
# create service principal for registry authentication
ACR_REGISTRY_ID=query_from_az_acr_show_--name_dggRegistry_--query_id
az ad sp create-for-rbac --name http://acr-sp --scopes ACR_REGISTRY_ID --role acrpush
# use 'appId' and 'password' from output 

#>
docker pull hello-world
docker tag hello-world dggregistry.azurecr.io/hello-world:dgg

docker login -u {appId} -p {password} dggregistry.azurecr.io

docker push dggregistry.azurecr.io/hello-world:dgg

docker rmi dggregistry.azurecr.io/hello-world:dgg

docker rmi hello-world:latest

docker pull dggregistry.azurecr.io/hello-world:dgg
