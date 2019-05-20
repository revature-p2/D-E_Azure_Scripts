#!/bin/bash

DOMAIN='ashuraazuregmail.onmicrosoft.com'
upn=$newuser@$DOMAIN

createUser() {

newuser=$1
sub=$2
pass='SupidPassword1234@#'

result=$(az ad user list --query [].userPrincipalName | grep -E /$upn/)

## checks if user already exists
if [ -n "$result" ]; then
echo "$newuser exists"
exit 1
fi

## if user doesn't exist then create one
if [ -z "$result" ]; then
az ad user create --display-name $newuser --password $pass --user-principal-name $upn --force-change-password-next-login --subscription $sub
echo "user born"
echo "your temporary password is $pass"
fi

}

#### assign roles ####

assign(){

theuser=$1
action=$2
role=$3

userCheck=$(az ad user list --query [].userPrincipalName | grep -E /$upn/)

## make/remove role

if [ -z "$userCheck" ]; then
echo "no user"
exit 1
fi

###we can just have dropdowns that will force these to be the options
if [ $role != "reader" ] && [ $role != "contributor" ]; then
echo "cannot assign"
exit 1
fi

if [ $action != "create" ] && [ $action != "delete" ]; then
echo "cannot do action"
exit 1
fi

#####

if [ -n "$userCheck" ]; then
az role assignment $action --role $role --assignee $upn
echo "changed role"
fi

}


#### delete user ####
deleteUser(){

theuser=$1

userCheck=$(az ad user list --query [].userPrincipalName | grep -E /$upn/)
adminCheck=$(az role assignment list --include-classic-administrators --query "[?id=='NA(classic admins)'].principalName" | grep -E /$theuser/)

## if no user is there then it exits
if [ -z "$userCheck" ]; then
echo "no user available to delete"
exit 1
fi

## do not delete an admin!
if [ -n "$adminCheck" ]; then
echo "please do not delete yourself"
exit 1
fi

## if user exists then remove them
if [ -n "$userCheck" ]; then
az ad user delete --upn-or-object-id $upn
echo "so long $theuser"
fi

}

user=$1

##check if admin

admin=$(az role assignment list --include-classic-administrators --query "[?id=='NA(classic admins)'].principalName" | grep -E /$user/)

if [ -z "$admin" ]; then
echo "not an admin, so go away"
exit 1
fi

## can now write in functions along with their parameters ##
command=$2
$command $3 $4 $5
