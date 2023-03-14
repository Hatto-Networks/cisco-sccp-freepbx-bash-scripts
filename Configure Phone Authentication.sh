#!/bin/bash
# This script will add a php file to /var/www/html/cisco_menu which just returns AUTHORIZED to the phone when the phone asks for login when doing HTTP stuff, like /CGI/Screenshot.

ip=`hostname  -I | cut -f1 -d' '`

echo Getting the PHP file...
wget https://hatto.dev/res/authentication.txt
echo Configuring...
[ -d "/var/www/html/cisco_menu" ] && cp ./authentication.txt /var/www/html/cisco_menu/authentication.php || mkdir /var/www/html/cisco_menu && cp ./authentication.txt /var/www/html/cisco_menu/authentication.php
rm -f ./authentication.txt
echo -e "\nAlright, my job's done. Now what you gotta do is go to your FreePBX dashboard, navigate to Sccp Connectivity > Server Config > SCCP Device URL, then paste the following:\n\n"
echo -e "https://${ip}/cisco_menu/authentication.php"
echo -e "\n\ninto Phone authentication URL(NOT Phone Secure authentication URL). After that remake your config files(Phones Manager, select all devices, Create CNF) and restart your Asterisk and phones."
