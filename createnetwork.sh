#!/bin/bash

az network nsg create --name nsg_public -g $username

az network nsg create --name nsg_private -g $username

az network nsg rule create --name in_rule --nsg-name nsg_public -g $username --priority 100 --direction inbound --source-address-prefixes 0.0.0.0/1 \
--source-port-ranges 22 80 443 --destination-address-prefixes 100.0.0.0/26 --destination-port-ranges 22 80 443 --protocol '*' 


az network nsg rule create --name out_rule --nsg-name nsg_public -g $username --priority 100 --direction outbound --source-address-prefixes 100.0.0.0/25 \
 --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --protocol '*'


az network nsg rule create --name in_rule --nsg-name nsg_private -g $username --priority 100 --direction inbound --source-address-prefixes 100.0.0.0/25 \
--source-port-ranges 22 --destination-address-prefixes '*' --destination-port-ranges 22 --protocol '*'


az network nsg rule create --name out_rule --nsg-name nsg_private -g $username --priority 100 --direction outbound --source-address-prefixes 100.0.0.128/25 \
 --source-port-ranges '*' --destination-address-prefixes '*' --destination-port-ranges '*' --protocol '*'

az network vnet create --name virutalnetwork -g $username --address-prefixes 100.0.0.0/24 --location southcentralus

az network vnet subnet create --address-prefixes 100.0.0.0/25 --vnet-name virtualnetwork -n subnet_public -g $username --network-security-group nsg_public

az network vnet subnet create --address-prefixes 100.0.0.128/25 --vnet-name virtualnetwork -n subnet_private -g $username --network-security-group nsg_private
