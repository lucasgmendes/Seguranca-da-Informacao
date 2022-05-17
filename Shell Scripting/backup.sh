#!/bin/bash

parametros=$@ #Pega todos os parâmetros de entrada

if [ $1 == '--help' ]
then
	echo '- Usage: bash backup.sh <arquivo1> <arquivo2> <arquivo3>...'
	echo '- Para alterar o local onde o arquivo será armazenado localmente, mude a variável CAMINHO_ARQUIVO.'
else	
	printf "Usuário: " #Usuario do computador remoto
	read usuario

	printf "Host: " #Host do computador remoto
	read host

	CAMINHO_ARQUIVO=/home/lucas/Desktop/laboratorio01/backups #diretorio onde os arquivos compactados ficarão na máquina local
	name=$CAMINHO_ARQUIVO/$(date +"%Y_%m_%d_%H_%M")

	acesso_ssh=$usuario@$host:/home/$usuario/laboratorio01/backups #destino do backup no computador remoto

	zip -r $name.zip $parametros #compacta os arquivos passados por parâmetro
	scp $name.zip $acesso_ssh #envia arquivo compactado para o computador remoto

	if [ $? -eq 0 ] #Se a saida for igual a 0 = operação deu certo
	then
		echo "Backup realizado com sucesso!!"
	else
		echo "Backup com falha! Tentativa de solução iniciada..."
		echo "Criando diretorio na máquina remota..."
		ssh $usuario@$host "cd /home/$usuario;mkdir laboratorio01; mkdir laboratorio01/backups; exit"

		scp $name.zip $acesso_ssh #envia arquivo compactado para o computador remoto
		if [ $? -eq 0 ]
		then
			echo "Backup realizado com sucesso!!"
		else
			echo "Backup falhou!!"
		fi
	fi
fi



