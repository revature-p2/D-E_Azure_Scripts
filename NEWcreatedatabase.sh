#!/bin/bash

username=$1
cosmos=$2 # name of database account
databaseName=$3 # name of database
collection=$4 # database collection name

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
