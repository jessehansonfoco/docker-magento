FROM php:7.3-fpm-buster

ARG APP_ID=1000

RUN apt-get update && apt-get install -y \
  cron \
  git \
  gzip \
  libbz2-dev \
  libfreetype6-dev \
  libicu-dev \
  libjpeg62-turbo-dev \
  libmcrypt-dev \
  libonig-dev \
  libpng-dev \
  libsodium-dev \
  libssh2-1-dev \
  libxslt1-dev \
  libzip-dev \
  lsof \
  default-mysql-client \
  vim \
  zip \
  procps \
  redis-server \
  rabbitmq-server

#for php 7.3
RUN docker-php-ext-configure gd --with-freetype-dir --with-jpeg-dir

#for php 7.4
#RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
  bcmath \
  bz2 \
  calendar \
  exif \
  gd \
  gettext \
  intl \
  mbstring \
  mysqli \
  opcache \
  pcntl \
  pdo_mysql \
  soap \
  sockets \
  sodium \
  sysvmsg \
  sysvsem \
  sysvshm \
  xsl \
  zip

RUN pecl channel-update pecl.php.net \
  && pecl install xdebug \
  && docker-php-ext-enable xdebug

RUN pecl install ssh2-1.2 \
  && docker-php-ext-enable ssh2

RUN pecl install redis \
  && docker-php-ext-enable redis

RUN apt-get install -y libmagickwand-dev \
  && pecl install imagick  \
  && docker-php-ext-enable imagick

RUN groupadd -g "$APP_ID" app \
  && useradd -g "$APP_ID" -u "$APP_ID" -d /var/www -s /bin/bash app

RUN apt-get install -y gnupg \
  && curl -sL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs \
  && mkdir /var/www/.config /var/www/.npm \
  && chown app:app /var/www/.config /var/www/.npm \
  && npm install -g grunt-cli

COPY php7.3 /usr/local/etc/php-fpm.d/
COPY php7.3 /usr/local/etc/php/
COPY php7.3 /usr/local/etc/

# Magento - create directories and set permissions

RUN mkdir -p /var/www/magento2 /sock \
  && chown -R app:app /var/www /usr/local/etc/php/conf.d /sock

USER app:app

WORKDIR /var/www/magento2

COPY --from=composer /usr/bin/composer /usr/bin/composer

EXPOSE 15671

CMD ["php-fpm"]
