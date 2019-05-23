#!/bin/bash

username=$1
vnetName=$2
vnetIP=$3
vnetMask=$4
privateSubnet=$5
privateIP=$6
publicSubnet=$7
publicIP=$8

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
