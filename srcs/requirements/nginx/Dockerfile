# Use the official Debian Buster image as a base
FROM debian:buster

# Update packages available
RUN apt-get update && apt-get upgrade -y

# Installation of necessary packages for nginx
RUN apt-get install nginx -y

# Installation of necessary packages for SSL
RUN apt-get install openssl -y

# Creating the directory for SSL certificates and private keys
RUN mkdir -p /etc/nginx/ssl

# Generating a self-signed SSL certificate from the private key
RUN openssl req -x509 -nodes -newkey rsa:2048\
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=Charente/L=Angouleme/O=42/OU=42/CN=ybaudoui.42.fr/UID=ybaudoui"

# config files
RUN mkdir -p /var/run/nginx

# Copy nginx.conf file to nginx config folder
COPY conf/nginx.conf /etc/nginx/nginx.conf

# principal root
RUN chmod 755 /var/www/html

# principal user
RUN chown -R www-data:www-data /var/www/html

# Starting nginx
CMD ["nginx", "-g", "daemon off;"]