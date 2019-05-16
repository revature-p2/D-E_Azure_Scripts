#!/bin/bash

case $1 in

nonrelational)

az cosmosdb create --name cosmos -g $username
az cosmosdb database create --db-name $databaseName --name cosmos -g $username
az cosmosdb collection create --collection-name $collection -g $username --db-name $databaseName --name cosmos
;;

relational)

az sql server create --location southcentralus -g $username --name sqlserver --admin-user $username --admin-password $password
az sql db create --group $username --server sqlserver --name $database --max-size 10GB

esac
