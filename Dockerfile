FROM php:8.2-cli

MAINTAINER Jonathan Bernardi <jon@jonbernardi.com>

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get install -qy \
    git \
    curl \
    wget \
    unzip \
    --no-install-recommends && \
    rm -r /var/lib/apt/lists/* && \
    apt-get --purge autoremove -y

# PHP Extensions
RUN install-php-extensions \
        bcmath gd pdo_mysql imagick intl pcntl imap \
        redis shmop soap sockets ssh2 tidy xml xsl zip


# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN apt-get clean -y && \
		apt-get autoremove -y && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
