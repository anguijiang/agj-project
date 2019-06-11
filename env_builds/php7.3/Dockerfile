FROM php:7.3-fpm-alpine

LABEL author="响当当"

ENV EXT_DEPENDENT=" \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libzip-dev \
        unixodbc-dev \
        freetds-dev \
        util-linux-dev" \
    BISIC_TOOLS="tzdata"

# BOOT_TYPE fpm scheduler queue
ENV BOOT_TYPE=fpm

ENV UID=1000

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
      && deluser www-data && addgroup -g $UID -S www-data && adduser -u $UID -D -S -G www-data www-data \
      && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
      && apk add --no-cache unixodbc freetds \
      && apk add $EXT_DEPENDENT \
      && docker-php-source extract \
      && echo '# https://github.com/docker-library/php/issues/103#issuecomment-271413933' >> temp.m4 \
      && echo "AC_DEFUN([PHP_ALWAYS_SHARED],[])dnl\n" >> temp.m4 \
      && cat /usr/src/php/ext/odbc/config.m4 >> temp.m4 \
      && mv temp.m4 /usr/src/php/ext/odbc/config.m4 \
      && mkdir /usr/local/incl && cp /usr/include/sqlext.h /usr/local/incl/ \
      && docker-php-ext-configure odbc  --with-unixODBC=shared,/usr && docker-php-ext-install -j$(nproc) odbc \
      && docker-php-ext-configure pdo_dblib && docker-php-ext-install -j$(nproc) pdo_dblib \
      && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
      && docker-php-ext-configure zip && docker-php-ext-install -j$(nproc) zip \
      && docker-php-ext-configure bcmath && docker-php-ext-install -j$(nproc) bcmath \
      && docker-php-ext-configure pdo_mysql && docker-php-ext-install -j$(nproc) pdo_mysql \
      && docker-php-ext-configure mysqli && docker-php-ext-install -j$(nproc) mysqli \
      && pecl install redis-4.3.0 && docker-php-ext-enable redis \
      && pecl install uuid && docker-php-ext-enable uuid \
      && apk add --no-cache ${BISIC_TOOLS} \
      && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
      && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && ls \
      && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
      && apk del --no-network .build-deps \
      && rm -rf /usr/src/php

# RUN apk add --no-cache unixodbc freetds

WORKDIR /wwwroot

USER www-data:www-data