#!/bin/bash

read -p "Entrez l'hôte de votre site: " site
if [ -z $site ]
then
  echo "L'hôte est obligatoire."
  exit 1
fi

read -p "Entrez le chemin de votre site: " docroot
if [ -z $docroot ]
then
  echo "Le chemin est obligatoire."
  exit 1
fi

read -p "Entrez l'adresse ip du serveur: " ipAddress
if [ -z $ipAddress ]
then
  ipAddress="127.0.0.1"
fi


virtualConf=/etc/apache2/sites-available/$site.conf

echo "<VirtualHost *:80>" >> $virtualConf
echo "	DocumentRoot \"$docroot\"" >> $virtualConf
echo "	DirectoryIndex app_dev.php" >> $virctualConf
echo "	ServerName $site" >> $virtualConf
echo "	<Directory \"$docroot\">" >> $virtualConf
echo "		AllowOverride All" >> $virtualConf
echo "		Allow from All" >> $virtualConf
echo "		Require All granted" >> $virtualConf
echo "	</Directory>" >> $virtualConf
echo "  CustomLog /var/log/apache2/$site_access.log" $site >> $virtualConf
echo "	ErrorLog /var/log/apache2/$site_error.log" >> $virtualConf
echo "</VirtualHost>" >> $virtualConf

echo "$ipAddress $site" >> /etc/hosts

a2ensite $site.conf
/etc/init.d/apache2 restart

