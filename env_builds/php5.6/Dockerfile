FROM php:5.6-fpm-alpine

LABEL author="响当当"

ENV EXT_DEPENDENT=" \
        libpng-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libzip-dev \
        util-linux-dev" \
    BISIC_TOOLS="tzdata"

ENV UID=1000

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
      && deluser www-data && addgroup -g $UID -S www-data && adduser -u $UID -D -S -G www-data www-data \
      && apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
      && apk add $EXT_DEPENDENT \
      && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j$(nproc) gd \
      && docker-php-ext-configure zip && docker-php-ext-install -j$(nproc) zip \
      && docker-php-ext-configure bcmath && docker-php-ext-install -j$(nproc) bcmath \
      && docker-php-ext-configure mysqli && docker-php-ext-install -j$(nproc) mysqli \
      && docker-php-ext-configure pdo_mysql && docker-php-ext-install -j$(nproc) pdo_mysql \
      && pecl install redis-4.3.0 && docker-php-ext-enable redis \
      && pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug \
      && pecl install uuid && docker-php-ext-enable uuid \
      && apk add --no-cache ${BISIC_TOOLS} \
      && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
      && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && ls \
      && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && composer config -g repo.packagist composer https://packagist.phpcomposer.com \
      && apk del --no-network .build-deps

WORKDIR /wwwroot

USER www-data:www-data