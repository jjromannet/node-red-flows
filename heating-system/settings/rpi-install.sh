#sudo raspi-config
#
#		a. Expand filesystem
#		b. Change user password

# retrieve info about most recent packages
sudo apt-get update

#remove unnecessary packages
apt-get --auto-remove --purge remove aptitude aptitude-common aspell aspell-en cifs-utils dbus dbus-x11 xserver-xorg-video-fbturbo gnome-icon-theme gnome-themes-standard-data dillo scratch xserver-xorg-input-synaptics zenity zenity-common xpdf xinit  xfonts-utils xfonts-encodings x11-common x11-utils x11-xkb-utils xarchiver timidity  
sudo apt-get clean

#update remaining packages 
sudo apt-get upgrade

#reboot just in case
sudo reboot

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
cd ~/installs
wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key
sudo apt-key add mosquitto-repo.gpg.key

cd /etc/apt/sources.list.d/
sudo wget http://repo.mosquitto.org/debian/mosquitto-stable.list

sudo apt-get update
sudo apt-get install mosquitto

#install & config MySQL
# TODO: sailent instalation - root password needed
sudo apt-get install mysql-server
#add remote access for root
mysql -u root -p
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%'
IDENTIFIED BY 'password' WITH GRANT OPTION;
FLUSH PRIVILEGES;
exit

sed 's/127.0.0.1/0.0.0.0/g' /etc/mysql/my.cnf | sudo tee /etc/mysql/my.cnf

#TODO: potentially decrease caches sizes

#setup kernel modules to startup
echo wiring | sudo tee --append /etc/modules
echo w1-gpio | sudo tee --append /etc/modules
echo w1-therm | sudo tee --append /etc/modules

#node modules
npm install es6-promise

#node-red modules
npm install node-red-node-mysql
npm install express --save
npm install nopt
npm install ds18b20

#node red
#latest file from: https://gist.github.com/Belphemur/cf91100f81f2b37b3e94
wget https://gist.githubusercontent.com/Belphemur/cf91100f81f2b37b3e94/raw/72e9a7e779ae343121ce535e312a9872fc9d5fb6/node-red
sudo mv node-red /etc/init.d/
sudo chmod +x /etc/init.d/node-red
sudo update-rc.d node-red defaults

git clone https://github.com/jjromannet/node-red.git

ln -s /home/pi/installs/node-red /home/pi/node-red 
#DHT Driver
#http://malinowepi.pl/post/80178679087/dht11-czujnik-temperatury-i-wilgotnosci-uklad
git clone git://github.com/adafruit/Adafruit-Raspberry-Pi-Python-Code.git


#deploy project ...
git clone git://github.com/jjromannet/node-red-projects.git

cp ~/installs/node-red-projects/heating-system/settings/settings.js ~/node-red/

cp ~/installs/node-red-projects/heating-system/flow/flows_raspberrypi.json ~/node-red/

cp -R ~/installs/node-red-projects/heating-system/front-end/* ~/node-red/public/

mysql -u root -p node-red < ~/installs/node-red-projects/heating-system/database/database-dump/database.sql

#TODO ...

#database deployment
#TODO clean deployment
#TODO incramental deployment

