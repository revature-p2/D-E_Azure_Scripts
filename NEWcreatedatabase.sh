#!/bin/bash
cosmos=$2 # name of database account
username=$3
databaseName=$4 # name of database
collection=$5 # database collection name
password=$6 # admin password
SQLdatabase=$7 # SQL database name

case $1 in

nonrelational)

result1=$(az cosmosdb list --query [].name | grep -E $cosmos) # database account
result2=$(az cosmosdb database list -n $cosmos -g $username --query [].id | grep -E $databaseName) # database
result3=$(az cosmosdb collection list -d $databaseName -g $username -n $cosmos --query [].id | grep -E $collection)

if [ -n "$result1" ]; then
    echo "$cosmos exists"
    exit 1
fi
if [ -n "$result2" ]; then
    echo "$databaseName exists"
    exit 1
fi
if [ -n "$result3" ]; then
    echo "$collection exists"
    exit 1
fi

az cosmosdb create --name $cosmos -g $username # create database account
az cosmosdb database create --db-name $databaseName --name $cosmos -g $username # create database
az cosmosdb collection create --collection-name $collection -g $username --db-name $databaseName --name $cosmos
;;

relational)

result4=$(az sql server list --query [].name | grep -E EricDavidsqlserver) # since sqlserver is static
result5=$(az sql db list --server EricDavidsqlserver -g $username --query [].name | grep -E $SQLdatabase)

if [ -n "$result4" ]; then
    echo "EricDavidsqlserver exists"
    exit 1
fi

# name of server will be all lowercase
if [ -n "$result5" ]; then
    echo "$SQLdatabase exists"
    exit 1
fi

az sql server create --location southcentralus -g $username --name EricDavidsqlserver \
 --admin-user $username --admin-password $password
az sql db create -g $username --server EricDavidsqlserver --name $SQLdatabase --max-size 10GB

esac