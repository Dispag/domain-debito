#!/bin/bash

echo Remover Imagens do Container --> Domain Debito
docker rmi -f `docker images -a | grep domain-debito_domaindebito| awk '{print $3}'`
