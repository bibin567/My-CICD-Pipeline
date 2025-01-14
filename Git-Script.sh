#!/bin/bash

sudo yum install httpd git -y
sudo amazon-linux-extras install php7.4 -y
sudo git clone https://github.com/bibin567/project.git /var/www/website_template
sudo cp -r /var/www/website_template/* /var/www/html/
sudo chown -R apache. /var/www/html/
sudo systemctl enable httpd.service
sudo systemctl restart httpd.service