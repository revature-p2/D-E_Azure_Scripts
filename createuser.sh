#!/bin/bash

userprincipalname=
az ad user create --display-name $username --password $password --user-principal-name $userprincipalname
echo Your login: $userprincipalname
az role assignment create --assignee $username --role b24988ac-6180-42a0-ab88-20f7382dd24c