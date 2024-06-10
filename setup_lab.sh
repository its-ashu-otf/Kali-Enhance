#!/bin/bash

echo "Installing ZSH Profile...."
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/its-ashu-otf/myZSH/main/setup.sh)"

echo "Installing Floorp..."
curl -fsSL https://ppa.ablaze.one/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/Floorp.gpg
sudo curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list 'https://ppa.ablaze.one/Floorp.list'
sudo apt update && sudo apt install floorp -y

echo "Fixing Numlock..."
wget -q --show-progress https://raw.githubusercontent.com/its-ashu-otf/Fix-my-Kali/main/numlockfix.sh
chmod +x numlockfix.sh
sudo ./numlockfix.sh
rm numlockfix.sh

echo "Fixing Snap Package Manager..."
wget -q --show-progress https://raw.githubusercontent.com/its-ashu-otf/Fix-my-Kali/main/snapd_fixer.sh
chmod +x snapd_fixer.sh
sudo ./snapd_fixer.sh
rm snapd_fixer.sh

echo "Done ! Reboot you're System to see the Changes..."
