# Copyright 2019 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM php:8.1-fpm
ENV DRUPAL_DATABASE_NAME=devportal \
    DRUPAL_DATABASE_USER=dbuser \
    DRUPAL_DATABASE_PASSWORD=dbpass \
    DRUPAL_DATABASE_HOST=localhost \
    DRUPAL_DATABASE_PORT=3306 \
    DRUPAL_DATABASE_DRIVER=mysql \
    ADMIN_USER=admin \
    ADMIN_PASS=admin \
    AUTO_INSTALL_PORTAL=false

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libxml2-dev \
        git zip unzip default-mysql-client\
        curl \
        bash \
        nginx \
        supervisor \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd bcmath opcache  pdo_mysql

RUN cp /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini \
    && sed -i 's/\(^max_execution_time = 30$\)/max_execution_time = 300/g' /usr/local/etc/php/php.ini \
    && echo "php_admin_value[memory_limit] = 512M" >> /usr/local/etc/php-fpm.d/www.conf \
    && sed -i 's/\(^;request_terminate_timeout = 0$\)/request_terminate_timeout = 300/g' /usr/local/etc/php-fpm.d/www.conf

WORKDIR /app/code/web
# COPY code /app/code/
COPY container-assets/startup.sh /startup.sh
COPY container-assets/set-permissions.sh /set-permissions.sh
COPY container-assets/drupal-nginx.conf /etc/nginx/sites-enabled/drupal-nginx.conf
COPY container-assets/supervisor.conf /etc/supervisor/conf.d/drupal-supervisor.conf

RUN chmod +x /startup.sh /set-permissions.sh 
RUN unlink /etc/nginx/sites-enabled/default

EXPOSE 80

CMD ["/startup.sh"]
