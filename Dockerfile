FROM php:7.2-fpm-alpine

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN docker-php-ext-install bcmath

RUN sed -i '/phpize/i \
    [[ ! -f "config.m4" && -f "config0.m4" ]] && mv config0.m4 config.m4' \
    /usr/local/bin/docker-php-ext-configure

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN mkdir /app

WORKDIR /app

COPY ./src/ /app/src/
COPY ./public/ /app/public/
COPY ./config/ /app/config/
COPY ./composer.* /app/

RUN composer update

RUN ls /app 
    
RUN rm -rf /var/cache/apk/*

CMD ["php-fpm"]
