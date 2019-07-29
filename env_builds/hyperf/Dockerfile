FROM hyperf/hyperf:7.3-alpine-cli

LABEL author="响当当"

ENV UID=1000

RUN addgroup -g $UID -S www-data && adduser -u $UID -D -S -G www-data www-data \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && php composer-setup.php && php -r "unlink('composer-setup.php');" && ls \
    && mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer && composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/
    
WORKDIR /wwwroot

USER www-data:www-data