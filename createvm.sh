#!/bin/bash

username=$1
vmname=$2
network=$3
vmsubnet=$4
user=$5
password=$6


vnetcheck=$(az network vnet list -g $username --query [].name | grep -E $network)
if [ -z $vnetcheck ]; then
echo "$network doesn't exists"
exit 1
fi

vmcheck=$(az vm list -g $username --query [].name | grep -E $vmname)
if [ -n $vmcheck]; then
echo "$vmname already exists"
exit 1
fi


## az vm list -g yoyo -d --query [].publicIps

az vm create --name $vmname --resource-group $username --image UbuntuLTS --location southcentralus --size B1s --admin-username $user \
--admin-password $password --vnet-name $network --subnet $vmsubnet --no-wait
echo Creating your Virtual Machine
echo $ipaddress
exit 0

