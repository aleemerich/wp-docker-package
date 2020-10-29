#!/bin/bash

# Pega o arquivo e envia ao servidor (ATENCAO: Este comando é usado para roda em PowerShell do Windows 10)
echo "Obtendo backup e enviando ao banco"
Get-Content .\dev.sql | docker exec -i docker_mysql_1 /usr/bin/mysql -u wordpress --password=wordpress wordpress

# Troca o domínio (algo.com.br) por localhost
echo "Trocando referëncias da URL original para 'localhost'"
docker exec -i docker_wordpress_1 wp search-replace 'seusite.com.br' 'localhost' --all-tables