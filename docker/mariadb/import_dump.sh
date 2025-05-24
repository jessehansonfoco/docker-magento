#!/bin/bash
docker exec -i mariadb-magento sh -c 'exec mysql -uroot -ppassw0rd -D clientname' < docker/mariadb/sql/dump.sql
