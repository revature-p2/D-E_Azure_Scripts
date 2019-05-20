#!/bin/bash

username=$1
network=$2

vnetcheck=$(az network vnet list -g $username --query [].id | grep -E /subscriptions/815e9f4d-e856-497c-8a3d-b2403a7b89e7/resourceGroups/$username/providers/Microsoft.Network/virtualNetworks/$network
if [ -z vnetcheck ]; then
echo No network found. Please configure one блядь.
exit 1
fi


i=1
if ! [virtualmachine$i]; then
az vm create --name virtualmachine$i --resource-group $username --image UbuntuLTS --location southcentralus --size B1s --admin-username $username \
--admin-password $password --vnet-name virtualnetwork --subnet $choice --no-wait
echo Creating your Virtual Machine
echo $ipaddress
exit 0
else
i+=1
az vm create --name virtualmachine$i --resource-group $username --image UbuntuLTS --location southcentralus --size B1s --admin-username $username \
--admin-password $password --vnet-name virtualnetwork --subnet $choice --no-wait
echo Creating your Virtual Machine
echo $ipaddress
exit 0
fi
