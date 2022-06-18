FROM php:8.0-apache
USER root
RUN docker-php-ext-install -j "$(nproc)" opcache
RUN docker-php-ext-install - j "$(nproc)" pdo pdo_mysql
RUN set -ex; \
    { \
    echo "; Cloud Run enforces memory & timeouts"; \
    echo "memory_limit = -1"; \
    echo "max_execution_time = 0"; \
    echo "; File upload at Cloud Run network limit"; \
    echo "upload_max_filesize = 32M"; \
    echo "post_max_size = 32M"; \
    echo "; Configure Opcache for Containers"; \
    echo "opcache.enable = On"; \
    echo "opcache.validate_timestamps = Off"; \
    echo "; Configure Opcache Memory (Application-specific)"; \
    echo "opcache.memory_consumption = 32"; \
    } > "$PHP_INI_DIR/conf.d/cloud-run.ini"



COPY src/ /var/www/html/
RUN ls -al /var/www/html
RUN chmod 777 /var/www/html/updates
RUN chmod 777 /var/www/html/storage
RUN chmod 777 /var/www/html/storage/avatars
RUN chmod 777 /var/www/html/storage/logos
RUN chmod 777 /var/www/html/storage/logos/clients
RUN chmod 777 /var/www/html/storage/logos/app
RUN chmod 777 /var/www/html/storage/files
RUN chmod 777 /var/www/html/storage/temp
RUN chmod 777 /var/www/html/application/storage/app
RUN chmod 777 /var/www/html/application/storage/app/public
RUN chmod 777 /var/www/html/application/storage/cache
RUN chmod 777 /var/www/html/application/storage/cache/data
RUN chmod 777 /var/www/html/application/storage/debugbar
RUN chmod 777 /var/www/html/application/storage/framework
RUN chmod 777 /var/www/html/application/storage/framework/cache
RUN chmod 777 /var/www/html/application/storage/framework/cache/data
RUN chmod 777 /var/www/html/application/storage/framework/sessions
RUN chmod 777 /var/www/html/application/storage/framework/testing
RUN chmod 777 /var/www/html/application/storage/framework/views
RUN chmod 777 /var/www/html/application/storage/logs
RUN chmod 777 /var/www/html/application/bootstrap/cache
RUN chmod 777 /var/www/html/application/storage/app/purifier
RUN chmod 777 /var/www/html/application/storage/app/purifier/HTML

RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
RUN a2enmod rewrite
RUN docker-php-ext-install mysqli
