#!/bin/bash

username=yoyo
vnetName=$1
vnetIP=$2
privateSubnet=$3
privateIP=$4
publicSubnet=$5
publicIP=$6
#numberofsubnets=$7

## conditional for vnet name
vnetcheck=$(az network vnet list -g $username --query [].name | grep -E $vnetName)
if ! [ -z $vnetcheck ]; then
echo "$vnetName already exists"
exit 0
fi

## conditional for subnet names
privatecheck=$(az network vnet list -g $username --query [].subnets[].name | grep -E $privateSubnet)
if ! [ -z $privatecheck ]; then
echo "$privateSubnet already exists"
exit 0
fi

publiccheck=$(az network vnet list -g $username --query [].subnets[].name | grep -E $publicSubnet)
if ! [ -z $privatecheck ]; then
echo "$privateSubnet already exists"
exit 0
fi

## validation to check if subnet isnt larger than vnet (currently psuedo code)
#if [ $privateIP > $vnetIP ] && [ $publicIP > $vnetIP ]; then
#echo "subnets need to be smaller than the network"
#exit 1
#fi


################################## Ashish logic trials

#mask=$(vnetIP | grep ..$)
#index=0
#for i in {2..2^(32-$mask)..*2}
#do
#index+=1
#cot=false
#if [ i=$numberofsubnets ]; then
#cot=true
#submask=$mask+$index
#break
#fi
#done

#if $cot=false; then
#echo invalid subnet request
#exit 1
#fi

#for L in {1..$numberofsubnets..1}
#do
#if [ $L%2==0 ]; then
#az network vnet subnet create --address-prefixes $publicIP --vnet-name $vnetName -n $publicSubnet -g $username --network-security-group nsg_public
#else
#az network vnet subnet create --address-prefixes $privateIP --vnet-name $vnetName -n $privateSubnet -g $username --network-security-group nsg_private
#fi



##################################
az network nsg create --name nsg_public -g $username

az network nsg create --name nsg_private -g $username

az network nsg rule create --name in_rule --nsg-name nsg_public -g $username --priority 100 --direction inbound --source-address-prefixes 0.0.0.0/1 \
--source-port-ranges 22 80 443 --destination-address-prefixes $publicIP --destination-port-ranges 22 80 443 --protocol '*' 


az network nsg rule create --name out_rule --nsg-name nsg_public -g $username --priority 100 --direction outbound --source-address-prefixes $publicIP \
 --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --protocol '*'


az network nsg rule create --name in_rule --nsg-name nsg_private -g $username --priority 100 --direction inbound --source-address-prefixes $publicIP \
--source-port-ranges 22 --destination-address-prefixes '*' --destination-port-ranges 22 --protocol '*'


az network nsg rule create --name out_rule --nsg-name nsg_private -g $username --priority 100 --direction outbound --source-address-prefixes $privateIP \
 --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --protocol '*'

az network vnet create --name $vnetName -g $username --address-prefixes $vnetIP --location southcentralus

az network vnet subnet create --address-prefixes $publicIP --vnet-name $vnetName -n $publicSubnet -g $username --network-security-group nsg_public

az network vnet subnet create --address-prefixes $privateIP --vnet-name $vnetName -n $privateSubnet -g $username --network-security-group nsg_private
