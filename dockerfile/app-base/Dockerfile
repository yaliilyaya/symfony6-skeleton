FROM php:8.2-fpm

COPY ./etc/local.ini /usr/local/etc/php/conf.d/local.ini

## Copy composer.lock and composer.json
#COPY composer.lock composer.json /var/www/

# Set working directory
WORKDIR /project

# Install dependencies
RUN apt-get update && apt-get install -y \
    gnupg \
    g++ \
    procps \
    openssl \
    git \
    unzip \
    zlib1g-dev \
    libzip-dev \
    libfreetype6-dev \
    libpng-dev \
    libjpeg-dev \
    libicu-dev  \
    libonig-dev \
    libxslt1-dev \
    acl \
    wget \
    && echo 'alias sf="php bin/console"' >> ~/.bashrc

# Install extensions
RUN docker-php-ext-configure gd --with-jpeg --with-freetype
RUN docker-php-ext-install pdo pdo_mysql zip xsl gd intl opcache exif mbstring
#RUN docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-png-dir=/usr/include/
#RUN docker-php-ext-install gd

RUN wget https://get.symfony.com/cli/installer -O - | bash \
    && mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN export PATH="$HOME/.symfony5/bin:$PATH"

RUN apt-get install -y supervisor
COPY ./etc/supervisord.conf /etc/supervisor/supervisord.conf
COPY ./etc/supervisor.d/ /etc/supervisor/conf.d/

EXPOSE 80 9001

#CMD ["tail", "-f", "/etc/hosts"]
CMD ["/usr/bin/supervisord", "--nodaemon", "-c" , "/etc/supervisor/supervisord.conf"]