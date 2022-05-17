#!/bin/bash
#Execução: bash compacta-diretorio.sh <caminho/diretorio> <caminho/destino/novo_nome> 

if [ $1 == '--help' ]; 
then
  echo 'Usage: bash compacta-diretorio.sh <caminho/diretorio> <caminho/destino/novo_nome>'
else
	caminho_diretorio=$1
	caminho_destino=$2

	chmod +rwx $caminho_diretorio

	echo $'Origem:' $caminho_diretorio $'\nDestino:' $caminho_destino $'\n'

	cd $caminho_diretorio
	zip -r $caminho_destino.zip ./*
fi