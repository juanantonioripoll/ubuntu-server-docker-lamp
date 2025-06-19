FROM php:8.3-apache

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
        sendmail \
        libpng-dev \
        libzip-dev \
        zlib1g-dev \
        libonig-dev \
        libjpeg-dev \
        libfreetype6-dev \
        unzip \
        curl \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install \
        mysqli \
        pdo \
        pdo_mysql \
        zip \
        mbstring \
        gd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Instalar Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN a2enmod rewrite

# Opcional: ajusta permisos del directorio web
# RUN chown -R www-data:www-data /var/www/html

# Opcional: copia configuración personalizada
# COPY ./apache-config.conf /etc/apache2/sites-available/000-default.conf

# Puerto por defecto
EXPOSE 80
