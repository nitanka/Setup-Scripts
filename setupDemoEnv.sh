#!/bin/bash

echo "############# Installing Java ################"

apt-add-repository ppa:webupd8team/java -y
apt-get update -y
 
####automatically agreeing on oracle license agreement that normally pops up while installing java8
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
 
####installing java
apt-get install -y oracle-java8-installer


echo "############# Installing Nginx Server #################"

apt-get install -y nginx 

echo "########### Installing MySQL Server ############"

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -y install mysql-server

echo "############### Creating MySQL Server #############"

mysql -u root -proot -e "create database blazent_db";

echo "############## Installing Nodejs #################"

curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

echo "nvm version is `nvm --version`"

echo "############### Installing nodejs ################"

nvm install node v6.2.1

echo "################# Installing git #####################"
apt-get install -y git

#echo "############## Installing Postfix ################"

#debconf-set-selections <<< "postfix postfix/mailname string `hostname`.com"
#debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
#apt-get install -y postfix

echo "########### Installing Maven ################"

apt-get install -y maven


echo "############# Installing redis ###############"
apt-get install redis-server

echo "#################Updating the kernel#################"
cd /tmp && wget http://kernel.ubuntu.com/~kernel-ppa/mainline/v4.1-unstable/linux-headers-4.1.0-040100-generic_4.1.0-040100.201507030940_amd64.deb && \
  dpkg -i *.deb 
