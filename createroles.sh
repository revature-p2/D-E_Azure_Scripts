#!/bin/bash

DOMAIN='ashuraazuregmail.onmicrosoft.com'
upn=$1@$DOMAIN
action=$2
role=$3

userCheck=$(az ad user list --query [].userPrincipalName | grep -E /$upn/)

## make/remove role

if [ -z "$userCheck" ]; then
echo "no user"
exit 1
fi

az role assignment $action --role $role --assignee $upn
echo "changed role"
