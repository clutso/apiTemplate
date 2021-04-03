# Template for a simple API using Python, flask and apache

## recipe

?# sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
?# pip3 install flask
# touch /var/www/api/__init__.py
# touch /var/www/api/my_flask_app.py
# touch /var/www/api/my_flask_app.wsgi
# apt-get install libapache2-mod-wsgi-py3
 
# sudo cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.old
 
#sudo nano /etc/apache2/sites-enabled/000-default.conf
 
 
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html
        WSGIDaemonProcess api user=user1 group=group1 threads=5
        WSGIScriptAlias / /var/www/api/api.wsgi

        <Directory /var/www/api>
                WSGIProcessGroup yourapplication
                WSGIApplicationGroup %{GLOBAL}
                Order deny,allow
                Allow from all
        </Directory>
		
		
#nano  /var/www/api/api.wsgi

import logging
import sys
logging.basicConfig(stream=sys.stderr)
sys.path.insert(0, '/home/ubuntu/flasktest/')
from my_flask_app import app as application
application.secret_key = 'holaMundo'


#nano /var/www/api/api.wsgi

from flask import Flask
app = Flask(__name__)

@app.route("/")
def home():
    return "Hey there!"

if __name__ == "__main__":
    app.run()


sudo systemctl restart apache


## Explained recipe 


