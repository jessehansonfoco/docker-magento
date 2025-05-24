FROM nginx

ARG APP_ID=1000

RUN groupadd -g "$APP_ID" app \
  && useradd -g "$APP_ID" -u "$APP_ID" -d /var/www -s /bin/bash app

# Nginx - configure
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/dev.clientsite.local.txt /etc/nginx/sites-enabled/dev.clientsite.local


# Nginx starts as root, then runs as user app
RUN mkdir -p /var/www/magento2 /sock && chown -R app:app /var/www /sock

CMD ["nginx", "-g", "daemon off;"]
