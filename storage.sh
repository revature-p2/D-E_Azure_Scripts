#!/bin/bash

username=$1
storagename=$2
container=$3


storagecheck=$(az storage account list -g $username --query [].name | grep -E $storagename)
if [ -n $storagecheck ]; then
echo "$storagename already exists"
exit 1
fi

containercheck=$(az storage container list --account-name $storagename --query [].name | grep -E $container)
if [ -n $containercheck ]; then
echo "$container already exists"
fi

az storage account create -n $storagename -g $username --sku Standard_LRS --encryption blob

az storage container create -n $container --account-name $storagename --public-access blob
