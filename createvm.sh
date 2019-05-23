#!/bin/bash

username=$1
vmname=$2
network=$3
vmsubnet=$4
user=$5
password=$6


vnetcheck=$(az network vnet list -g $username --query [].id | grep -E /subscriptions/815e9f4d-e856-497c-8a3d-b2403a7b89e7/resourceGroups/$username/providers/Microsoft.Network/virtualNetworks/$network
if [ -z $vnetcheck ]; then
echo No network found. Please configure one блядь.
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

