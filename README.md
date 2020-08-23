# README
## What is this repository for?
Vagrant box with shell provisioning. Installs Ubuntu 16.04 with PHP7.1, mysql, phpunit, git, vim, node, npm and apache. Basically universal LAMP stack.

## How do I get set up?
Run vagrant up from directory and next chose connection ie. 1


**NOTES FOR DEBUGGING**

1) SSH Auth problem
    Use key inside .vagrant/machines/default/virtualbox/private_key
    Copy our idrsa_pub key into ~/.ssh/authorised_keys in our guest machine
    ssh-add -L - if that returns empty add our id_rsa key to it

2) Mysql errors
    Make sure php7.1-mysql is installed
    Make sure php7.1 pdo extension is installed
    Make sure etc/mysql/my.cnf is configures properly
    composer.phar require doctrine/dbal

3) index.php errors
    enable mod rewrite in apache: **sudo a2enmod rewrite**
    restart apache server
    
edit .htaccess to point to public/index.php:

    <IfModule mod_rewrite.c>
     RewriteEngine On
     RewriteBase /
     RewriteCond %{REQUEST_FILENAME} !-f
     RewriteCond %{REQUEST_FILENAME} !-d
     RewriteRule . /public/index.php [L]
    </IfModule>

In public/.htaccess put this code:

    Options +FollowSymLinks
    RewriteEngine On
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteRule ^ index.php [L]


Next in apache vhosts edit the .conf file to enable rewrite on all:

    DocumentRoot /var/www/html/public
    <Directory var/www/html/public>
            Options Indexes FollowSymLinks
            AllowOverride All
            allow from all
    </Directory>
    
4) Permission problem. After setting laravel folders to 777, we also have to add user and group to Vagrantfile.
    Vagrant does not permit to use chown, so users/group have to be changed before vagrant up. That change was made to Vagratfile

5) Remote mysql connection details ie. sequel pro  
MySQL Host: 192.168.33.xx (or any other chosen in Vagrantfile) / in some cases: 127.0.0.1  
Username: user  
Password: password  
Port: 3306 (or any other chosen in Vagrantfile)  
SSH Host: 127.0.0.1  
SSH User: vagrant  
SSH Key: insecure from keys in .vagrant folder - refer to problems with auth  
SSH Port: 2222 (or any other chosen in Vagrantfile)<br/>  

6) Package not found while installing new packages  
```
sudo su  
apt-get clean  
cd /var/lib/apt  
mv lists lists.old  
mkdir -p lists/partial  
apt-get clean  
apt-get update
```

## Adding GUI desktop environment   
The easy way:  
1) Uncomment vb.gui in Vagrantfile  
2) run sudo apt-get install ubuntu-desktop  
3) Login as vagrant/vagrant

More complicated way:  
1) sudo apt-get install xfce4  
2) sudo startxfce4&


## Who do I talk to?
@copy Wojciech Zaorski
