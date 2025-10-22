# 1. Set the base image.
FROM php:8.4-apache

# 2. Install Xdebug.
#RUN pecl install xdebug \
#    && docker-php-ext-enable xdebug

# 3. Change the Apache document root.
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

#4. Install packages, extensions and composer.
RUN apt-get update && apt-get install -y \
    vim \
    git \
    unzip \
    curl \
    zlib1g-dev \
    libzip-dev \
    less \
    libpq-dev \
    postgresql \
    && docker-php-ext-install \
    zip \
    bcmath

# install-php-extensions PHP のエクステンション をインストール
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions opcache intl opcache sockets exif imagick gd mbstring pdo pdo_pgsql pgsql

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl -s http://getcomposer.org/installer | php && \
    echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
    mv composer.phar /usr/local/bin/composer

#5. Install the GD library.
#RUN apt-get update && apt-get install -y \
#    gcc \
#    libfreetype6-dev \
#    libjpeg-dev \
#    libmcrypt-dev \
#    libpng-dev \
#    libjpeg62-turbo-dev \
#    make \
#    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
#    && docker-php-ext-install -j$(nproc) gd

# 6. Make "npm install" executable on the container for using Vue.js.
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get update && apt-get install -y \
    nodejs

# 7. Enable mod_rewrite.
RUN a2enmod rewrite

#8. Make postgreSQL accessible from the container.
#RUN set -ex apk --no-cache add postgresql-dev libpq-dev && \
#    apt-get update && apt-get install -y \
#    less \
#    libpq-dev \
#    postgresql \
#    && docker-php-ext-install \
#    mbstring \
#    pdo \
#    pdo_pgsql \
#    pgsql