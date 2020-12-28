FROM php:7.4-apache

LABEL version="1.0.0" \
      description="Base image Debian 10 Buster с PHP" \
      maintainer="SedovSG@yandex.ru"

ARG UID
ARG GID
ARG UNAME

ENV BUILD_DEPS \
    ca-certificates \
    sudo \
    zip \
    unzip \
    libzip-dev

ENV PHP_DEPS \
    bcmath \
    opcache \
    gmagick \
    mysqli \
    openssl \
    pdo_mysql \
    pdo_pgsql \
    pgsql \
    sqlite3 \
    yaml \
    zip \
    bz2 \
    xsl \
    gd

COPY . .

ADD entrypoint.sh /usr/local/bin/entrypoint.sh

ADD ./config/apache2/vhost.conf /etc/apache2/sites-enabled/000-default.conf
ADD ./config/apache2/apache2.conf /etc/apache2/

RUN apt-get update -y && apt-get install -y ${BUILD_DEPS} --no-install-recommends \
    && apt-get autoremove -y && apt-get autoclean && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/* /var/tmp/* \
    && rm -rf /usr/share/doc && rm -rf /usr/share/man \
    && chmod +x /usr/local/bin/entrypoint.sh \
    && usermod -u $UID -aG sudo $UNAME && groupmod -g $GID $UNAME \
    && echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
    && mkdir -p /home/$UNAME/.composer \
    && a2enmod rewrite headers \
    && docker-php-ext-install ${PHP_DEPS}

ADD ./config/php/php.ini "$PHP_INI_DIR/php.ini"

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www/html/

USER $UNAME

EXPOSE 8088

ENTRYPOINT ["entrypoint.sh"]
