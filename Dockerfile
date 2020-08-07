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



ENV URLSHORTNER_VERSION 0.1-alpha
ENV URLSHORTNER_SHA256 c4e0541b517cb545da43b477144518c212022680d7b8b105cae5b159f634db95

RUN set -eux; \
    curl -o urlshortner.tar.gz -fsSL "https://github.com/engprodigy/urlshortner/archive/${URLSHORTNER_VERSION}.tar.gz"; \
    echo "$URLSHORTNER_SHA256 *urlshortner.tar.gz" | sha256sum -c -; \
# upstream tarballs include ./urlshortner-${URLSHORTNER_VERSION}/ so this gives us /usr/src/urlshortner-${URLSHORTNER_VERSION}
    tar -xf urlshortner.tar.gz -C /usr/src/; \
# move back to a common /usr/src/urlshortner
    mv "/usr/src/urlshortner-${URLSHORTNER_VERSION}" /usr/src/urlshortner; \
    rm urlshortner.tar.gz; \
    chown -R www-data:www-data /usr/src/urlshortner

COPY docker-entrypoint.sh /usr/local/bin/
COPY config-docker.php /usr/src/urlshortner/user/
COPY .htaccess /usr/src/urlshortner/
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
