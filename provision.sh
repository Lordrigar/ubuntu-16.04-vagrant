# Provision and setup by Lordrigar
#!/usr/bin/env bash

###### Install SED and update ubuntu ######
sudo apt install --reinstall sed -y
sudo apt-get update && sudo apt-get upgrade -y


###### Install apache2 and change config file ######
sudo apt-get install apache2 -y
echo "ServerName localhost" >> /etc/apache2/apache2.conf
sudo service apache2 restart
sudo apache2ctl configtest

###### Install PHP 7.1 ######
sudo apt-add-repository ppa:ondrej/php -y
sudo apt-get update -y
sudo apt-get install php7.1 -y
sudo apt-get install php7.1-xml -y
sudo apt-get install php7.1-mbstring -y
sudo apt-get install php7.1-mysql

###### Install MYSQL server and client ######
echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
apt-get install -y mysql-server mysql-client

###### Adjust MYSQL config files ######
sed -i 's/skip-external-locking/#skip-external-locking/g' /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i 's/bind-address/#bind-address/g' /etc/mysql/mysql.conf.d/mysqld.cnf

##### Add vagrant user to www-data group #####
sudo usermod -a -G www-data vagrant

###### Restart mysql and apache ######
sudo service apache2 restart -y
sudo service mysql restart

###### Create user and grant privilages ######
mysql -uroot -proot <<MYSQL_SCRIPT
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON * . * TO 'user'@'localhost';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'user'@'10.0.2.2';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# echo "FLUSH PRIVILEGES;"
sudo mysql -h 127.0.0.1 -uroot -proot

# ###### Restart mysql and apache ######
sudo service apache2 restart
sudo service mysql restart

###### Install composer ######
sudo apt-get update
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

###### Install GIT ######
apt-get install git -y
git config --global user.name ""
git config --global user.email ""

###### zip and unzip extenstions for PHP7 ######
sudo apt install zip unzip php7.0-zip -y

###### Install phpunit ######
sudo composer require --dev phpunit/phpunit ^6.5

###### Install npm and node ######
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node

###### Remove tiny-vim and install proper vim ######
sudo apt remove vim-tiny -y
sudo apt update
sudo apt install vim -y

###### Install figlet to display message ######
npm install -g figlet-cli -y
figlet "Ready to roll!"
