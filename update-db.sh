#!/bin/bash
pv bk/dev.sql.gz | gunzip | docker exec -i docker_mysql_1 mysql -u wordpress --password=wordpress wordpress

echo "Trocando tudo para 'localhost'"
docker exec -i docker_wordpress_1 wp search-replace DOMAIN localhost --all-tables