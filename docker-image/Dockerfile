FROM wordpress:latest

# Install the PHP extensions we need
RUN set -ex;\
	apt-get update; \
	apt-get install -y \
		git \
		libzip-dev \
		mariadb-client \
		sudo \
		subversion \
#		telnet \
#		iputils-ping \
#		traceroute \
	; \
	apt-get install -y \
		--no-install-recommends ssl-cert \
	; \
	rm -rf /var/lib/apt/lists/*; \
	a2enmod ssl; \
	a2ensite default-ssl; \
	docker-php-ext-install zip; 
#	yes | pecl install xdebug

# Git config
RUN git config --global user.name "WP-DOCKER-PACKAGE Project"; \
	git config --global user.email "temp@temp.com";

# PHPCS
RUN cd /var/www; \
	git clone https://github.com/squizlabs/PHP_CodeSniffer.git phpcs; \
	git clone https://github.com/PHPCSStandards/PHPCSUtils.git phpcs-utils; \
	git clone https://github.com/sirbrillig/phpcs-variable-analysis.git phpcs-varanalysis; \
	git clone https://github.com/WordPress/WordPress-Coding-Standards.git phpcs-wpcs; \
	git clone https://github.com/Automattic/VIP-Coding-Standards.git phpcs-vipcs;

RUN	echo 'alias phpcs="php /var/www/phpcs/bin/phpcs"' >> ~/.bashrc; \
    /var/www/phpcs/bin/phpcs --config-set installed_paths /var/www/phpcs-utils/,/var/www/phpcs-varanalysis/,/var/www/phpcs-wpcs/,/var/www/phpcs-vipcs/;

### ToDo FUTURO: Install Xdebug manual
# RUN git clone https://github.com/xdebug/xdebug.git; \
#     cd xdebug/; \
#     phpize; \
#     ./configure --enable-xdebug; \
# 	make; \
# 	make install;

### ToDo FUTURO: Node + libraries + Gulp

WORKDIR /var/www/html
VOLUME /var/www/html

# Change www-data user to match the host system UID and GID and chown www directory
RUN usermod --non-unique --uid 1000 www-data \
  && groupmod --non-unique --gid 1000 www-data \
  && chown -R www-data:www-data /var/www

EXPOSE 80 443

# Overrides wp docker default entrypoint
COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["apache2-foreground"]