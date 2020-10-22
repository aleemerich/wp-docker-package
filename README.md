# Ambiente Wordpress completo para desenvolvimento

## Visão geral

Este projeto é baseado no projeto de [Felipe Elia](`https://github.com/felipeelia/docker-base-env`) e tem por objetivo criar através de um arranjo de scripts e estruturas de pastas um ambiente completo para rodar o Wordpress, na sua versão mais recente com algumas ferramentas de extrema importância para quem desenvolve em WordPress.

Neste ambiente você vai encontrar:
1. Um servidor Web contendo a versão mais atual do `Wordpress` junto com a biblioteca `WP-Cli`
2. Um servidor de banco de dados `MySQL`
3. Um servidor web rodando `PHPMyAdmin`
4. Um servidor com uma ferramenta de intercepção de e-mail chamada `MailHog` (esta ferramenta interceptará todos os e-mails disparados pelo servidor para que você veja tudo o que seu servidor dispara).
5. Scripts para criar backups do banco de dados e restarações de outras bases.

**Lembre-se:** Este projeto permite você rodar apenas *uma* aplicação Wordpress. Para trabalhar com várias, é perciso criar um repositório para cada (cabe ver se é viável). Outro ponto importante é que está é uma ferramenta para desenvolvimento, **não** use essa configuração para *ambiente de produção*. Por fim, obviamente, é necessário que você tenha do Docker previmente configurado em sua máquina.

## Como instalar

Clone o repositório do GitHub
````sh
git clone https://github.com/aleemerich/wp-docker-package.git
````
Você também pode download em ZIP deste projeto e descompactar onde você ache mais conveniente. Se quiser retirar o versionamento GIT deste projeto, apague a pasta `.git`.

Acesse a pasta `docker` dentro do projeto e execute o comando
````sh
docker-compose up
````

Após isso, basta acessar `http://localhost` para iniciar a configuração do Wordpress, ou seja, você estará iniciando uma versão totalmente limpa do Wordpress

## Informações complementares

### MailHog
- Servidor configurado em `http://localhost:8025`
- Para funcionar corretamente, mantenha o arquivo `docker/dev.ini`.

### PHPMyAdmin
- Servidor configurado em `http://localhost:8080`

## MySQL (MariaDB)
- A base de dados criada será a padrão do Wordpress, criada após a configuração incial executada.
- Se quiser gerar um backup da base atual em atividade, execute `./dump-db.sh`. 
- Para restaurar um backup, execute `./update-db.sh`. CUIDADO: Isso sobrescreverá a base atual.
