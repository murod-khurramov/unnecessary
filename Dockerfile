# PHP Laravel uchun Dockerfile
FROM php:8.2-fpm

# Asosiy paketlarni o'rnatish
RUN apt-get update && apt-get install -y \
    zip unzip git curl libpq-dev \
    && docker-php-ext-install pdo pdo_pgsql

# Composer o'rnatish
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Loyihani container ichiga ko'chirish
WORKDIR /var/www
COPY . .

# Laravel permissionlarini sozlash
RUN chown -R www-data:www-data /var/www/storage /var/www/bootstrap/cache

# Laravel uchun tayyorgarlik
RUN composer install --no-dev --optimize-autoloader

CMD ["php-fpm"]
