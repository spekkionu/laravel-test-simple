FROM php:7.1.11

MAINTAINER Jonathan Bernardi <jon@jonbernardi.com>

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get dist-upgrade -y && \
    apt-get install -qy \
    git \
    curl \
    wget \
    unzip \
    libmcrypt-dev \
    --no-install-recommends && rm -r /var/lib/apt/lists/* \
    && apt-get --purge autoremove -y
		
# PHP Extensions
RUN docker-php-ext-install \
    mcrypt

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get clean -y && \
		apt-get autoremove -y && \
		rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
