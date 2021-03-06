#!/bin/bash

username=$1
server=$2
user=$3
password=$4
SQLdatabase=$5

result=$(az sql server list -g $username --query [].name | grep -E $server)

if [ -n "$result" ]; then
    echo "$server exists"
    exit 0
fi


az sql server create --location southcentralus -g $username --name $server \
 --admin-user $user --admin-password $password

result2=$(az sql db list --server $server -g $username --query [].name | grep -E $SQLdatabase)
# name of server will be all lowercase
if [ -n "$result2" ]; then
    echo "$SQLdatabase exists"
    exit 0
fi


az sql db create -g $username --server $server --name $SQLdatabase --max-size 10GB
