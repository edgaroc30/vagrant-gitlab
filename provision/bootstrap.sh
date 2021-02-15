#!/usr/bin/env bash

sudo cp /home/vagrant/vagrant /srv/sql/prd/backup.bak
sudo cp /home/vagrant/vagrant /srv/sql/qa/backup.bak
sudo cp /home/vagrant/vagrant /srv/sql/dev/backup.bak

# Print the VM IP address + Some information about the containers
ip addr show eth1 | egrep "inet\ " | cut -f1 -d "/" | cut -f2 -d "t"
echo "SQL User: SA / Password: LWv9QWhPEk6A6nyv"
echo "SQL DEV Port: 1433"
echo "SQL QA Port: 1443"
echo "SQL PRD Port: 1453"
# echo "Gitlab User: root / Passowrd: gitlabroot , Port: 80"
ip addr show eth1 | egrep "inet\ " | cut -f1 -d "/" | cut -f2 -d "t"