#!/bin/bash
#FURTHER WORK --> validate python version
#error=$(( python -v )2>&1)
#echo $error

sudo apt update
sudo apt full-upgrade -yq
sudo apt install apache2 python3-pip libapache2-mod-wsgi-py3 -yq
pip3 install flask

# LINES NOT NEEDED UNLESS DECIDE TO USE ANOTHER LOCATION TO INSTALL
#sudo mkdir /var/www/api
#sudo touch /var/www/api/__init__.py
#sudo touch /var/www/api/my_flask_app.py
#sudo touch /var/www/api/my_flask_app.wsgi

sudo cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.old


sudo bash -c  '
FILE=$(ls *.wsgi)
NAME=$(echo "$FILE" | cut -d "." -f1)
IDir=$(pwd)

cat << EOF > /etc/apache2/sites-enabled/000-default.conf
<VirtualHost *:80>
# script replaced by PIT restore the orignal by runningoriginal
# sudo cp /etc/apache2/sites-enabled/000-default.conf.old /etc/apache2/sites-enabled/000-default.conf
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html


        WSGIDaemonProcess $NAME user=ubuntu group=ubuntu threads=5
        WSGIScriptAlias /api $IDir/$FILE
        <Directory /var $IDir>
                WSGIProcessGroup  $NAME
                WSGIApplicationGroup %{GLOBAL}
                Require all granted
        </Directory>

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>



EOF'