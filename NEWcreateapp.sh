#!/bin/bash

username=$1
gitrepo=$2
application=$3 

# resource group is the same as their sign on name.

result=$(az webapp list -g $username --query [].defaultHostName | grep -E $application)

if [ -n "$result" ]; then
    echo "$application exists"
    exit 1
fi

result2=$(az appservice plan list -g $username --query [].name | grep -E serviceplan)
if [ -z "$result2" ]; then
az appservice plan create --name serviceplan -g $username --sku F1 --location southcentralus --is-linux 
fi

az webapp create -g $username --plan serviceplan --name $application -r "node|10.14"
    
az webapp deployment source config --name $application -g $username --repository-type github --repo-url $gitrepo \ 
--branch master