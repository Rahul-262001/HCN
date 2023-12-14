FROM php:apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Remove default Apache HTML files
RUN rm -rf /var/www/html/*

# Copy your HTML and PHP files
COPY index.php /var/www/html/index.php
COPY uploads /var/www/html/uploads

EXPOSE 80

CMD ["apache2-foreground"]
