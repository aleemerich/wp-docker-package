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

## Como criar seu ambiente
Clone o repositório do GitHub
````sh
git clone https://github.com/aleemerich/wp-docker-package.git
````
Você também pode fazer o download em ZIP deste projeto e descompactar onde você ache mais conveniente. Se quiser retirar o versionamento GIT deste projeto, apague a pasta `.git`.

##### Subir o ambiente pela primeira vez
Acesse a pasta `docker` dentro do projeto e execute o comando
````sh
docker-compose up --build
````
O Docker irá usar a imagem em `docker-image/Dockerfile-wp` para compilar a versão inicial do servidor Apache/PHP/Wordpress além de também realizar as outras ações referente aos outros servidores e serviços.

O script também irá checar se já existe uma versão do Wordpress na pasta `dev/`. Caso esta pasta esteja em branco, a última versão do Wordpress será copiada para esta pasta. Caso já exista uma versão do Wordpress na pasta, será mantido o que existe.

Assim que o ambiente estiver funcional, basta acessar `http://localhost` para iniciar a configuração do Wordpress, caso seja usado um Wordpress que acabaou de ser baixado. Caso precise das credenciais já criadas nesse ambiente, seguem abaixo:
- Nome do banco: **wordpress**
- Nome do usuário: **wordpress**
- Senha: **wordpress**
- Servidor do banco de dados: **mysql**
- Prefixo: *fica a seu critério* (padrão: *wp*)

As seguinte URL também ficarão disponíveis:
- PHPMyAdmin: http://localhost:8080/
- MailHog: http://localhost:8025/

#### As próximas execuções
Nas próximas vezes que for subir seu ambiente, basta acessar a basta 'docker/' e usar o comando
````sh
docker-compose up
````
Volta a usar o parâmetro `--build` se fizer qualquer alteração nos arquivos do Docker ou .sh usados dentro de `docker/` ou `docker-image/`.

## Fique atento 
- Seu desenvolvimento deve se concentrar dentro da pasta `dev/`, mas este projeto não versiona a pasta `dev/`, logo usar o git deste projeto **não** versionará nada que fizer em `dev/`. *Dica:* crie um projeto git para seu plugin e/ou tema e trate como um projeto extra, com pull e push próprios.
- Se for usar plugins de terceiros, é preciso fazer a instalação inicial apenas, depois esses plugins ficarão dentro da estrutura Wordpress contida em `dev/`. Porém, *se acontecer algo ao seu micro e a pasta `dev` se perder*, vocë terá que possivelmente refazer a instalação dos plugins ou ao menos voltar os arquivos perdidos.
- Caso precise definir novas confogurações para o PHP, edite o arquivo `docker/dev.ini`.
- Se o serviço que sobre o servidor Apache/Wordpress acusar o erro *exec user process caused "no such file or directory"*, altere o tipo de quebra de linha do arquivo *"docker-image/docker-entrypoint.sh"* para *'LF'* (ao invés de *'CRLF'*). Essa confusão de padrão Linux e Windows para quebra de linha pode levar a erros na execução de arquivos bash (.sh).

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

##### Configurando o VSCode para funcionar o Xdebug

Para debugar o PHP do container do Worpress no VSCode dentro do seu Windows, é preciso colocar uma configuração na parte de Debug, para isso, acesse o menu "Run", depois "Open Configurations". O VSCode deverá abrir o arquivo `launch.json` para você editar. Dentro deste arquivo você deve adicionar as seguintes linhas:

````sh
"configurations": [
        {
            "name": "XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "pathMappings": {
                "/var/www/html/": "${workspaceRoot}/dev",
            }
        }
    ]
````

O principal ponto neste aqquivo é a configuraçao `pathMappings`. Nela você precisa ter certeza de apontar o local onde os arquivos PHP estão, tanto no container, quanto na sua máquina (isso é totalmente vinculado com "volumes"). *Lembre-se*, se a pasta raiz do projeto for a pasta onde você clonou o projeto, então o path de exemplo servirá, caso contrário será preciso ajustar o path do exemplo acima para que coincida com a pasta onde estão os arquivos na sua máquina Windows.


## Próximos passos
- Incorporar ferramentas para automação de testes PHP e Wordpress
- Tentar usar o recurso de multisite do Wordpress para ver se funciona
- Puder configurar mais que uma aplicação Wordpress
