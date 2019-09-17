#!/usr/bin/env bash

# Get updates and upgrade
# sudo apt-get update
# sudo apt upgrade -y

# Install apache container
 sudo docker run --detach --name apache -v /srv/apache/logs:/usr/local/apache2/logs httpd:2.4
 # sudo docker cp CONTAINER:/usr/local/apache2/conf/ /srv/apache/
 sudo docker kill apache
 sudo docker rm apache
 sudo docker run --detach \
 --name apache \
 -v /srv/apache/logs:/usr/local/apache2/logs \
 -p 80:80 \
 -p 8080:8080 \
 -p 23:22 \
 httpd:2.4
 #-v /srv/apache/conf/:/usr/local/apache2/conf/ \

# Print the VM IP address
ip addr show eth1 | egrep "inet\ " | cut -f1 -d "/" | cut -f2 -d "t"