
# Configure MySQL root password
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'

# Install packages
apt-get update
apt-get -y install mysql-server-5.5 php5-mysql libsqlite3-dev apache2 php5 php5-dev php5-gd build-essential php-pear


# Set timezone
echo "Chiacgo/New_York" | tee /etc/timezone
dpkg-reconfigure --frontend noninteractive tzdata


# Setup database
echo "DROP DATABASE IF EXISTS test" | mysql -uroot -proot
echo "CREATE USER 'wp'@'localhost' IDENTIFIED BY 'root'" | mysql -u root -proot
echo "CREATE DATABASE wp" | mysql -uroot -proot
echo "GRANT ALL ON wp.* TO 'wp'@'localhost'" | mysql -uroot -prootv
echo "FLUSH PRIVILEGES" | mysql -uroot -proot

# Apache changes
# add line to end of conf file
echo "<Directory /var/www/wp>" >> /etc/apache2/apache2.conf
echo " Options Indexes FollowSymLinks" >> /etc/apache2/apache2.conf
echo " AllowOverride All" >> /etc/apache2/apache2.conf
echo " Require all granted" >> /etc/apache2/apache2.conf
echo " </Directory>" >> /etc/apache2/apache2.conf
echo "ServerName localhost" >> /etc/apache2/apache2.conf
echo "User vagrant" >> /etc/apache2/apache2.conf
echo "Group vagrant" >> /etc/apache2/apache2.conf
a2enmod rewrite

# rewrite default.conf from provided source (nfs-linked to host)
cat /var/custom_config_files/apache2/default | tee /etc/apache2/sites-available/000-default.conf

# Configure PHP
sed -i '/display_errors = Off/c display_errors = On' /etc/php5/apache2/php.ini
sed -i '/error_reporting = E_ALL & ~E_DEPRECATED/c error_reporting = E_ALL | E_STRICT' /etc/php5/apache2/php.ini
sed -i '/html_errors = Off/c html_errors = On' /etc/php5/apache2/php.ini


# Make sure things are up and running as they should be (generates warning if port in use...)
service apache2 restart




mkdir /var/www/wp/sites/default/files
chmod 777 /var/www/wp/sites/default/files
cp /var/www/wp/sites/default/default.settings.php /var/www/wp/sites/default/settings.php
chmod 777 /var/www/wp/sites/default/settings.php

# install
cd /var/www/
wget http://wordpress.org/latest.tar.gz
tar -xzvf latest.tar.gz 
mv wordpress wp



# WPCLI
cd /usr/local/bin/
curl -O http://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
mv wp-cli.phar wp
chmod +x wp
wp --info

#WPCLI companion
cd /home/vagrant
curl -O http://github.com/wp-cli/wp-cli/raw/master/utils/wp-completion.bash

