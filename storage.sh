#!/bin/bash

username=yoyo
storagename=$1
container=$2


storagecheck=$(az storage account list -g $username --query [].name | grep -E $storagename)
if ! [ -z $storagecheck ]; then
echo "$storagename already exists"
exit 0
fi

az storage account create -n $storagename -g $username --sku Standard_LRS --encryption blob

containercheck=$(az storage container list --account-name $storagename --query [].name | grep -E $container)
if ! [ -z $containercheck ]; then
echo "$container already exists"
fi

az storage container create -n $container --account-name $storagename --public-access blob

