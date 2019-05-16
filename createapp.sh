#!/bin/bash


az appservice plan create --name serviceplan -g $username --sku F1 --location southcentralus --is-linux
az webapp create -g $username --plan serviceplan --name application -r "node|10.14"
az webapp deployment source config --name application -g $username --repository-type github --repo-url $gitrepo --branch master