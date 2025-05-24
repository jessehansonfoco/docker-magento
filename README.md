<h2>How to Set up Docker</h2>

### Workflow (after setup steps are finished)
* Start Servers
  * $ docker-compose up -d
* edit code as normal
* Enter php container and run terminal commands as normal
    * $ ./docker/magento/bash.sh
    * $ exit , to logout
* $ docker-compose down

### Windows
* Install WSL 2
  * https://docs.microsoft.com/en-us/windows/wsl/install
  * ensure you can run docker command inside ubuntu
* Install Docker for WSL 2
  * https://docs.docker.com/desktop/windows/wsl/
  * follow the steps carefully . if you already installed docker via apt, you'll need to uninstall it
* clone repo from _inside_ Ubuntu
  * open Ubuntu terminal
  * you may need to copy ssh keys into /home/username/.ssh/
    * ~/.ssh/id_rsa , id_rsa.pub
    * both files need 400 permissions (read-only)
  * create your folders
  * git clone repo.git

### Linux
* adjust permissions so that you do not need to run sudo docker
    * https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-userI
* ensure you're not already running web server on port 80, or redis on port 6379 , mysql on port 3306
  * you can adjust port numbers, as described below
* git clone from _outside_ the docker instance
* if you encounter errors while running setup:upgrade, you may need to delete some folders to reset permissions
    * from _inside_ docker instance, run:
    * $ rm -rf generated/code/* pub/static/frontend/JustForMen pub/static/adminhtml/Magento var/view_preprocessed/pub/static
* if your styles-m.css doesn't load:
    * from _inside_ docker instance run:
    * $ bin/magento setup:static-content:deploy -f

### Quick Start Summary
* add entry to hosts file
  * 127.0.0.1    dev.clientsite.local dev.clientsite2.local
* Build images for Nginx, php-fpm
  * $ ./docker/build_images.sh
  * this script also copies a modified nginx.conf.sample to nginx.conf
* copy docker/magento/env.php to app/etc/env.php
* $ docker-compose up -d
* copy sql file to docker/mariadb/sql/dump.sql
    * the filename _must_ match, and it must be a text/sql file
* import database dump, and update base url's
  * $ ./docker/build_db.sh
  * note: there are also individual scripts for dropping db, creating db, importing dump, updating base urls
* $ ./docker/magento/bash.sh
  * from here, we can use the terminal like normal:
  * $ composer update
  * $ composer install
  * $ bin/magento setup:upgrade
  * $ bin/magento setup:di:compile

### FYI
* the hostnames in docker-compose.yml are used in app/etc/env.php . We do not need to manage IP addresses
* the mysql root password in docker-compose.yml is used in app/etc/env.php
  * also in docker/mariadb/*sh
* the nginx port number is configured in:
  * docker/nginx/conf/vhost
  * docker/mariadb/sql/base_urls.sql
  * docker-compose.yml
* you can change the base url . It just needs to match your hosts file

### Basic Commands
* docker ps
  * shows running container-names and port numbers
* docker ps --all
  * shows any stopped containers, as well as running containers and port numbers
* docker images
  * list docker images and hash
* docker rmi image-hash
  * remove image by hash. container must be stopped
* docker stop container-name
  * stop a container by container-name
