# Ambiente para desenvolemento em Wordpress
Este é um projeto pessoal para estudo e que tem como objetivo criar um ambiente totalmente automatizado para desenvolvimento Wordpress com uso de Docker e outras ferramentas de automação fortemente usadas no mercado.

# Visão geral

Este projeto é baseado no projeto de [Felipe Elia](https://github.com/felipeelia/docker-base-env) e tem por objetivo criar, através de um arranjo de scripts, Dockerfile, Docker-compose e estruturas de pastas, um ambiente completo de desenvolvimento para Wordpress, na sua versão mais recente. Além disso, será agregado algumas ferramentas de extrema importância para desenvolvedores em geral.

Neste ambiente você vai encontrar:
1. Um servidor web `Apache` com:
1.1 Um `Dockerfile` (Dockerfile-wp) para vocë alterar caso deseje
1.2 `Wordpress` em sua última versão
1.3 Executando `PHP 7.4`
1.4 Biblioteca `WP-Cli` ativa e funcional
1.5 Ferramenta `Xdbug` já configurada
2. Um servidor de banco de dados `MySQL` rodando MariaDB
3. Um servidor web rodando `PHPMyAdmin` em sua última versão
4. Um servidor com uma ferramenta de intercepção de e-mail chamada `MailHog` (esta ferramenta interceptará todos os e-mails disparados pelo servidor para que você veja tudo o que seu servidor dispara).
5. Scripts para criar backups do banco de dados e restarações de outras bases.

**Lembre-se:** 
- Este projeto permite você rodar apenas *uma* (01) aplicação Wordpress. Para trabalhar com várias, é perciso criar um repositório para cada (cabe ver se é viável).
- Está é uma ferramenta para desenvolvimento, **não é recomendado** usar este ambiente para criação de um *ambiente de produção*. 
- Obviamente, é necessário que você tenha do Docker previmente configurado em sua máquina.

## Como instalar

Clone o repositório do GitHub
````sh
git clone https://github.com/aleemerich/wp-docker-package.git
````
Você também pode fazer o download em ZIP deste projeto e descompactar onde você ache mais conveniente. Se quiser retirar o versionamento GIT deste projeto, apague a pasta `.git`.

Acesse a pasta `docker` dentro do projeto e execute o comando
````sh
docker-compose up
````

Após isso, basta acessar `http://localhost` para iniciar a configuração do Wordpress, ou seja, você estará iniciando uma versão totalmente limpa do Wordpress

**Alguns avisos:** 
- O servidor que será iniciado está totalmente na sua versão orininal (limpo)
- Os dados referente a aplicação Wordpress serão descarregado em `dev/`, portanto seu desenvolvimento deve se concentrar nessa pasta, mas este projeto não versiona a pasta `dev/`, logo usar o git deste projeto **não** versionará nada que fizer em `/dev`. *Dica:* crie um projeto git para seu plugin e/ou tema e trate como um projeto extra, com pull e push próprios.
- Se for usar plugins de terceiros, é preciso fazer a instalação inicial apenas, depois esses plugins ficarão dentro da estrutura Wordpress contida em `dev/`. Porém, *se acontecer algo ao seu micro e a pasta `dev` se perder*, vocë terá que possivelmente refazer a instalação dos plugins ou ao menos voltar os arquivos perdidos.
- Caso precise definir novas confogurações para o PHP, edite o arquivo `docker/dev.ini`.


## Informações complementares
Abaixo algumas informações que podem auxiliar você no trabalho com este projeto

##### Dockerfile
O arquivo docker-compose deste projeto usa 3 serviços, onde 2 são baeados em imagens nativas (repositório Docker) e um terceiro é baseado em uma imagem criada a partir de um Dockerfile próprio. Essa imagem é referente ao servidor que rodará o Wordpress e se você quiser alterar as configurações, vá até a pasta `docker-image` e altere o que desejar no arquivo Dockerimage-WP. 

Se qusier criar apenas essa imagem (se utilizar todos os serviços do Docker Compose), basta citar o nome ao rodar build:
````sh
cd /docker-image
docker build -t <nome da imagem que quiser dar> -f .\Dockerfile-wp .
````


##### MailHog
- Servidor configurado em `http://localhost:8025`
- Para funcionar corretamente, mantenha o arquivo `docker/dev.ini`.

##### PHPMyAdmin
- Servidor configurado em `http://localhost:8080`

##### MySQL (MariaDB)
- A base de dados criada será a padrão do Wordpress, criada após a configuração incial executada.
- Se quiser gerar um backup da base atual em atividade, execute `./dump-db.sh`. 
- Para restaurar um backup, execute `./update-db.sh`. CUIDADO: Isso sobrescreverá a base atual.

Se trabalhar com bases de dados grandes, é aconselhável de forma manual copiar o arquivo de backup para dentro do server MySQL e executar o restore para minimizar efeitos indesejados de timeout e afins. Para fazer a cópia de sua máquina para o server MySQL, use:

````sh
docker cp nome_backup.sql docker_mysql_1:/nome_backup.sql
````

## Próximos passos
- Incorporar ferramentas para atuomação de testes PHP e Wordpress
- Tentar usar o recurso de multisite do Wordpress para ver se funciona
- Puder configurar mais que uma aplicação Wordpress