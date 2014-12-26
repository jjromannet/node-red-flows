#!/bin/bash	
#argument 3 - stage 
#	1 - copy install script from boot
#	2 - remove desktop and not used packages
#	3 - install and deploy 

#argument 1 - front end password 
#argument 2 - database root password 

if [ "$3" == "1" ]
then
	echo 'Stage: 1'


sudo cp /boot/rpi-install.sh /home/pi/
sudo chown pi rpi-install.sh
sudo chgrp pi rpi-install.sh
chmod +x rpi-install.sh
fi
#
#--------- END OF STAGE 1
#

if [ "$3" == "2" ]
then
	echo 'Stage: 2'
#sudo raspi-config
#		a. Expand filesystem - not really needed 

echo "pi:$1" | sudo chpasswd

# retrieve info about most recent packages
sudo apt-get --yes --force-yes update

#remove unnecessary packages
sudo apt-get --auto-remove --purge --yes --force-yes remove aptitude aptitude-common aspell aspell-en cifs-utils dbus dbus-x11 xserver-xorg-video-fbturbo gnome-icon-theme gnome-themes-standard-data dillo scratch xserver-xorg-input-synaptics zenity zenity-common xpdf xinit  xfonts-utils xfonts-encodings x11-common x11-utils x11-xkb-utils xarchiver timidity 'libx11-.*' task-desktop
sudo apt-get --yes --force-yes install screen
sudo apt-get --yes --force-yes clean

#update remaining packages 
sudo apt-get --yes --force-yes upgrade

#reboot just in case
sudo reboot
fi
#
#--------- END OF STAGE 2
#
if [ "$3" == "3" ]
then
	echo 'Stage: 3'
#create working directory
mkdir installs
cd installs

#install NODE
wget http://node-arm.herokuapp.com/node_latest_armhf.deb
sudo dpkg -i node_latest_armhf.deb

#install WiringPi
git clone git://git.drogon.net/wiringPi
cd wiringPi
git pull origin
cd wiringPi
./build

#install Mosquitto
cd /home/pi/installs
wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
sudo apt-key add mosquitto-repo.gpg.key

cd /etc/apt/sources.list.d/
sudo wget http://repo.mosquitto.org/debian/mosquitto-stable.list

cd /home/pi/installs/
sudo apt-get -y install mosquitto

#install mysql silently
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $2"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $2"
sudo apt-get -y install mysql-server


#add remote access for root
echo -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'\n"\
"IDENTIFIED BY '$2' WITH GRANT OPTION;\n"\
"FLUSH PRIVILEGES;\n" | mysql -u root --password=$2

#creating node-red user with random username and password

randomHash=`head /dev/urandom | sha256sum  | awk '{ print $1 }'`
#TODO: set up node-red user
NRUlogin="node-red-${randomHash:0:4}"
NRUpassword=${randomHash:4}

echo -e "CREATE USER '$NRUlogin'@'localhost' IDENTIFIED BY '$NRUpassword';\n"\
"GRANT SELECT,INSERT,UPDATE ON \`node-red\`.* TO '$NRUlogin'@'localhost';\n"\
"FLUSH PRIVILEGES;\n" | mysql -u root --password=$2

sed 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf | sudo tee /etc/mysql/my.cnf
#TODO: tune mysql cache / buffers size for raspberry pi

#setup kernel modules to startup
echo wiring | sudo tee --append /etc/modules
echo w1-gpio | sudo tee --append /etc/modules
echo w1-therm | sudo tee --append /etc/modules

#node modules
npm install es6-promise

#node-red modules
npm install ds18b20
npm install node-red-node-mysql

#node red
#latest file from: https://gist.github.com/Belphemur/cf91100f81f2b37b3e94
cd /home/pi/installs/
wget https://gist.githubusercontent.com/Belphemur/cf91100f81f2b37b3e94/raw/72e9a7e779ae343121ce535e312a9872fc9d5fb6/node-red
sudo mv node-red /etc/init.d/
sudo chmod +x /etc/init.d/node-red
sudo update-rc.d node-red defaults

git clone https://github.com/jjromannet/node-red.git

ln -s /home/pi/installs/node-red /home/pi/node-red 
cd /home/pi/node-red
npm install --production
#DHT Driver
#http://malinowepi.pl/post/80178679087/dht11-czujnik-temperatury-i-wilgotnosci-uklad
cd /home/pi/installs/
git clone git://github.com/adafruit/Adafruit-Raspberry-Pi-Python-Code.git

#deploy project ...
git clone git://github.com/jjromannet/node-red-projects.git

#replace password:
passwordMd5=`echo -n $1 | md5sum | awk '{ print $1 }'`
sed "s/{PASSWORD}/$passwordMd5/g" /home/pi/installs/node-red-projects/heating-system/settings/settings.js > /home/pi/node-red/settings.js
#TODO: Test
cat /home/pi/installs/node-red-projects/heating-system/settings/flows_raspberrypi_cred.json | sed "s/{PASSWORD}/$NRUpassword/g" | sed "s/{LOGIN}/$NRUlogin/g" | sudo tee /home/pi/node-red/flows_raspberrypi_cred.json

cp /home/pi/installs/node-red-projects/heating-system/flow/flows_raspberrypi.json /home/pi/node-red/

cp -R /home/pi/installs/node-red-projects/heating-system/front-end/* /home/pi/node-red/public/

echo -e "CREATE DATABASE `node-red`;" | mysql -u root --password=$2

 -u root -password=$2 node-red < ~/installs/node-red-projects/heating-system/database/database-dump/database.sql

#TODO flow incremental deployment

fi
#
#--------- END OF STAGE 3
#