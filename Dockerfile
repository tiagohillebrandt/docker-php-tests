FROM php:5.6-fpm

# Install system basics
RUN set -ex; \
    apt-get update && apt-get install -y \
        git \
        unzip \
        curl \
        subversion

# Enables Xdebug
RUN pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug

# Enable mysqli extension for PHP
RUN docker-php-ext-install mysqli

# Install PHPUnit
RUN curl -sSL https://phar.phpunit.de/phpunit-5.7.phar -o /usr/local/bin/phpunit; \
    chmod +x /usr/local/bin/phpunit

# Install WP-CLI
RUN version=$(curl -s https://api.github.com/repos/wp-cli/wp-cli/tags | egrep -o "v[0-9].[0-9]{1,}.[0-9]" | sort | uniq -d | tail -n1 | sed 's/^v//g'); \
    curl -sSL https://github.com/wp-cli/wp-cli/releases/download/v$version/wp-cli-$version.phar -o /usr/local/bin/wp; \
    chmod +x /usr/local/bin/wp

# Install Composer
RUN curl -sSL https://getcomposer.org/composer.phar -o /usr/local/bin/composer; \
    chmod +x /usr/local/bin/composer
