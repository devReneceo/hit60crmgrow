FROM php:7.2-apache
COPY src/ /var/www/html/
# RUN chmod 777 /var/www/html/updates
# RUN chmod 777 /var/www/html/storage
# RUN chmod 777 /var/www/html/storage/avatars
# RUN chmod 777 /var/www/html/storage/logos
# RUN chmod 777 /var/www/html/storage/logos/clients
# RUN chmod 777 /var/www/html/storage/logos/app
# RUN chmod 777 /var/www/html/storage/files
# RUN chmod 777 /var/www/html/storage/temp
# RUN chmod 777 /var/www/html/application/storage/app
# RUN chmod 777 /var/www/html/application/storage/app/public
# RUN chmod 777 /var/www/html/application/storage/cache
# RUN chmod 777 /var/www/html/application/storage/cache/data
# RUN chmod 777 /var/www/html/application/storage/debugbar
# RUN chmod 777 /var/www/html/application/storage/framework
# RUN chmod 777 /var/www/html/application/storage/framework/cache
# RUN chmod 777 /var/www/html/application/storage/framework/cache/data
# RUN chmod 777 /var/www/html/application/storage/framework/sessions
# RUN chmod 777 /var/www/html/application/storage/framework/testing
# RUN chmod 777 /var/www/html/application/storage/framework/views
# RUN chmod 777 /var/www/html/application/storage/logs
# RUN chmod 777 /var/www/html/application/bootstrap/cache
# RUN chmod 777 /var/www/html/application/storage/app/purifier
# RUN chmod 777 /var/www/html/application/storage/app/purifier/HTML
# RUN chmod 777 /var/www/html/application/.env
RUN a2enmod rewrite
RUN docker-php-ext-install bcmath

RUN apt-get update -y && apt-get install -y sendmail libpng-dev

RUN apt-get update && \
    apt-get install -y \
    zlib1g-dev 

RUN docker-php-ext-install mbstring

RUN docker-php-ext-install zip

RUN docker-php-ext-install gd
RUN docker-php-ext-install mysqli
ENV SETUP_STATUS=COMPLETED
ENV ENFORCE_SSL=false
ENV DB_CONNECTION=mysql
ENV DB_HOST=127.0.0.1
ENV DB_PORT=3306
ENV DB_DATABASE=HIT_60
ENV DB_USERNAME=root
ENV DB_PASSWORD="cm6eJgj5prxoHp1H"
ENV APP_URL=http://localhost
ENV APP_NAME="CRM"
ENV APP_ENV=production
ENV APP_KEY=base64:aNBBQ58FMwnQzbg8Uk9Z/Tt1nDi1d7LisxsyUeViHw0=
ENV APP_INSTALLED_VERSION=1.08
ENV ENFORCE_SSL=false