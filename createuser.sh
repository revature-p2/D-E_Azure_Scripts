#!/bin/bash

create() {

pass='SupidPassword1234@#'

result=$(az ad user list --query [].userPrincipalName | grep -E $upn)

## checks if user already exists
if [ -n "$result" ]; then
echo "$newuser exists"
exit 1
fi

## if user doesn't exist then create one
if [ -z "$result" ]; then
az ad user create --display-name $theuser --password $pass --user-principal-name $upn --force-change-password-next-login --subscription Revature
echo "user born"
echo "your temporary password is $pass"
fi

}

#### delete user ####
delete(){

userCheck=$(az ad user list --query [].userPrincipalName | grep -E $upn)
adminCheck=$(az role assignment list --include-classic-administrators --query "[?id=='NA(classic admins)'].principalName" | grep -E $theuser)

## if no user is there then it exits
if [ -z "$userCheck" ]; then
echo "no user available to delete"
exit 0
fi

## do not delete an admin!
if [ -n "$adminCheck" ]; then
echo "please do not delete yourself"
exit 0
fi

## if user exists then remove them
if [ -n "$userCheck" ]; then
az ad user delete --upn-or-object-id $upn
echo "so long $theuser"
fi

}


##check if admin

#admin=$(az role assignment list --include-classic-administrators --query "[?id=='NA(classic admins)'].principalName" | grep -E $theuser)

#if [ -z "$admin" ]; then
#echo "not an admin, so go away"
#exit 1
##fi

## can now write in functions along with their parameters ##
command=$1
theuser=$2
DOMAIN='ashuraazuregmail.onmicrosoft.com'
upn=$theuser@$DOMAIN
$command

