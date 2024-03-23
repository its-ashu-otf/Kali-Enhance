#!/bin/bash

echo "Snapd Fix By its_ashu_otf"
echo " "
echo "Checking the repository and updating it...."
#usual repository and package updates
sudo apt update
echo " "
sudo apt upgrade -y
echo " "
echo "Installing Snap, If already installed it will be skipped.....:)"
#checking if snapd is installed or not
sudo apt install snapd
echo " "
echo "Linking Snapd to local application path"
#this will link snapd paths with local application paths 
ln -s /var/lib/snapd/desktop/applications ~/.local/share/applications/snap
echo " "
echo "Adding Snapd Binaries to System-Wide Enviroment Variables"
sudo sed -i '/^PATH=/ s|$|:/snap/bin|' /etc/environment
echo " "
echo "you might need to restart your system for the changes to take effect globally"


