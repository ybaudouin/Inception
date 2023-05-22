FROM debian:buster

# update
RUN apt-get update && \
    apt-get upgrade -y

# Installation wget (for download internet files)
RUN apt-get -y install wget

# Install php7.3 and dependencies
RUN apt-get install -y php7.3\
	php-fpm\
	php-mysql\
	mariadb-client

# ********WORDPRESS********

# Install wordpress 6.0 and select the file where I want to install it with -P option
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www

# Extract and delete the file download
RUN cd /var/www && tar -xzf wordpress-6.0-fr_FR.tar.gz && rm wordpress-6.0-fr_FR.tar.gz

# Give root permission to write to this folder.
RUN chown -R root:root /var/www/wordpress

# ********CLI********

# Install CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

# Give permission
RUN chmod +x wp-cli.phar

# move binary
RUN mv wp-cli.phar /usr/local/bin/wp

# Copy files conf
COPY conf/php.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY tools/auto_config.sh /auto_config.sh

RUN chmod +x auto_config.sh

# ********EXEC********

ENTRYPOINT ["bash", "auto_config.sh"]