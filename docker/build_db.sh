#!/bin/bash
./docker/mariadb/import_dump.sh
./docker/mariadb/update_base_urls.sh
