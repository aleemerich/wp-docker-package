#!/bin/bash
docker exec -i docker_wordpress_1 mysqldump -h mysql -u wordpress -pwordpress --add-drop-table wordpress > "./bk/dev.sql"
