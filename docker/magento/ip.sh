#!/bin/bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' clientname-magento
