#!/bin/bash

username=yoyo
vmname=$1
network=$2
vmsubnet=$3
user=$4
password=$5


vnetcheck=$(az network vnet list -g $username --query [].name | grep -E $network)
if [ -z $vnetcheck ]; then
echo "$network doesn't exists"
exit 0
fi

vmcheck=$(az vm list -g $username --query [].name | grep -E $vmname)
if ! [ -z $vmcheck]; then
echo "$vmname already exists"
exit 0
fi


az vm create --name $vmname -g $username --image UbuntuLTS --location southcentralus --size Standard_B1ls --admin-username $user \
--admin-password $password --vnet-name $network --subnet $vmsubnet

ipaddress=$(az vm list -d --query "[?name=='$vmname'].publicIps")

echo connect to your vm with $ipaddress

