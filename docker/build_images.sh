#!/bin/bash
cp docker/magento/magento-nginx.conf nginx.conf
docker build -t clientname-nginx:latest ./docker/nginx
docker build -t clientname:latest ./docker/magento
