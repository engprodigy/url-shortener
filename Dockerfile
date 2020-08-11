FROM php:7.4-apache

# install the PHP extensions we need
RUN set -eux; \
    docker-php-ext-install -j "$(nproc)" opcache pdo_mysql mysqli

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN a2enmod rewrite expires

RUN rm -rf /var/lib/apt/lists/*
RUN apt-get update 
RUN apt-cache gencaches
#RUN apt-get install zip -y 
#RUN apt-get install unzip

#RUN apt-get install php-cli php-mbstring git unzip
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
#COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
RUN apt-get update && apt-get -y --no-install-recommends install git unzip \
    && php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer \
    && rm -rf /var/lib/apt/lists/*

ENV URLSHORTNER_VERSION master
ENV URLSHORTNER_SHA256 92da69e6ee3546e2d13987e272be2804f34f41e20ae1fa19ffdf38028fbb1c35
RUN set -eux; \
    curl -o urlshortner.zip -fsSL "https://github.com/engprodigy/urlshortner/archive/${URLSHORTNER_VERSION}.zip"; \
    echo "$URLSHORTNER_SHA256 *urlshortner.zip" | sha256sum -c -; \
# upstream tarballs include ./urlshortner-${URLSHORTNER_VERSION}/ so this gives us /usr/src/urlshortner-${URLSHORTNER_VERSION}
    unzip -o urlshortner.zip -d /usr/src/; \
# move back to a common /usr/src/urlshortner
    mv "/usr/src/urlshortner-${URLSHORTNER_VERSION}" /usr/src/urlshortner; \
    rm urlshortner.zip; \
    chown -R www-data:www-data /usr/src/urlshortner

COPY docker-entrypoint.sh /usr/local/bin/
COPY config-docker.php /usr/src/urlshortner/user/
COPY .htaccess /usr/src/urlshortner/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
