# Template for a simple API using Python, flask and apache

## recipe

Working and tested on:

- 03/04/2021
- AWS t2.micro using Ubuntu Server 18.04 LTS image


```
# git clone https://github.com/clutso/apiTemplate.git
# cd apiTemplate
# chmod 755 setup.sh 
# ./setup.sh
```

test entering http://<your.ip.addr.ess>/api/


## Detailed explaination 

First thing to do is to install some tools and dependencies:

    - apache2 (sudo apt install apache2)
    - python3-pip (sudo apt install python3-pip)
    - libapache2-mod-wsgi-py3 (sudo apt install libapache2-mod-wsgi-py3)

Is highly important that python 3.6 or greater is installed, you can take a look by running:

    # python -V

or 

    # python3 -V

In case you experience issues try solvng by running:

    # sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1

Then get the python dependencies:
    
    - flask (**pip3 install flask** or **pip install flask**)

Proceed to backup apache config

    # sudo cp /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-enabled/000-default.conf.old

Next thing to do is to edit apache configuration file (you will need do this as superuser):

    #sudo nano /etc/apache2/sites-enabled/000-default.conf
 
 inside that file you may have sometihing similar to this (replace \<with your values\> properly)

    ServerAdmin webmaster@localhost
    DocumentRoot /var/www/html
    WSGIDaemonProcess <your_app_name> user=<your_user> group=<your_user_group threads=5
    WSGIScriptAlias /<your_root_api_endpoint> </route/to/your/api>/<your_app_name>.wsgi

    <Directory </route/to/your/api>>
        WSGIProcessGroup <your_app_name>
        WSGIApplicationGroup %{GLOBAL}
        Order deny,allow
        Allow from all
    </Directory>
    
Then you may populate a *.wsgi file  

    #nano  </route/to/your/api>/<your_app_name>.wsgi

Try something like this (don't forget to properly replace \<with your values\>): 
    
    import logging
    import sys
    logging.basicConfig(stream=sys.stderr)
    sys.path.insert(0, '/home/ubuntu/flasktest/')
    from my_flask_app import app as application
    

Don't forget to create your app file, 
    
    #nano  </route/to/your/api>/<your_app_name>.py

This is a very simple example: 

    from flask import Flask
    app = Flask(__name__)

    @app.route("/")
    def home():
        return "Hey there!"

    if __name__ == "__main__":
        app.run()

Finally restart apache to reload changes

    #sudo systemctl restart apache

Test by entering your IP address and appending the endpoint you have specified..

Enjoy!
