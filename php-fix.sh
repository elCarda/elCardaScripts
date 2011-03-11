#remove all php packages
sudo aptitude purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "`
# use karmiс for php pakage
# pin-params:  a (archive), c (components), v (version), o (origin) and l (label).
echo -e "Package: php5\nPin: release v=karmic\nPin-Priority: 991\n" > sudo tee /etc/apt/preferences.d/php > /dev/null
apt-cache search php5-|grep php5-|awk '{print "Package:", $1,"\nPin: release v=karmic\nPin-Priority: 991\n"}'|sudo tee  /etc/apt/preferences.d/php > /dev/null
# add karmic to source list
sed s/lucid/karmic/g /etc/apt/sources.list | sudo tee -a /etc/apt/sources.list.d/karmic.list
# update package database (use apt-get if aptitude crash)
sudo apt-get update
# install php
sudo aptitude install -t karmic php5 php5-pgsql php5-xdebug php5-tidy php5-curl php5-imap php5-xsl php5-cli php5-mysql
sudo aptitude hold libapache2-mod-php5 php5 php5-common php5-pgsql php5-xdebug php5-tidy php5-curl php5-imap php5-xsl php5-cli php5-mysql
#done
service apache2 restart
