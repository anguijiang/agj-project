FROM php:7.0-fpm-alpine

LABEL author="响当当"

ENV EXT_DEPENDENT=" \
        libpng-dev \
        libzip-dev \
        util-linux-dev" \
    BISIC_TOOLS="tzdata"

# BOOT_TYPE fpm scheduler queue
ENV BOOT_TYPE=fpm

ENV UID=1000

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
      && deluser www-data && addgroup -g $UID -S www-data && adduser -u $UID -D -S -G www-data www-data \
      && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
      && apk add $EXT_DEPENDENT \
      && docker-php-ext-configure gd && docker-php-ext-install -j$(nproc) gd \
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
      && apk del --no-network .build-deps

WORKDIR /wwwroot

USER www-data:www-data