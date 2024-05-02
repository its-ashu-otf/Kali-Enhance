#!/bin/bash

#Script Title: SnapD Fix
#Author: its_ashu_otf
#Description: A Bash script which Fixes Snap for Kali-Linux

cat << "EOF"

 _____  _   _   ___  ______ ______    ______  _____ __   __   ______ __   __   _  _                             _                            _     __ 
/  ___|| \ | | / _ \ | ___ \|  _  \   |  ___||_   _|\ \ / /   | ___ \\ \ / /  (_)| |                           | |                          | |   / _|
\ `--. |  \| |/ /_\ \| |_/ /| | | |   | |_     | |   \ V /    | |_/ / \ V /    _ | |_  ___           __ _  ___ | |__   _   _           ___  | |_ | |_ 
 `--. \| . ` ||  _  ||  __/ | | | |   |  _|    | |   /   \    | ___ \  \ /    | || __|/ __|         / _` |/ __|| '_ \ | | | |         / _ \ | __||  _|
/\__/ /| |\  || | | || |    | |/ /    | |     _| |_ / /^\ \   | |_/ /  | |    | || |_ \__ \        | (_| |\__ \| | | || |_| |        | (_) || |_ | |  
\____/ \_| \_/\_| |_/\_|    |___/     \_|     \___/ \/   \/   \____/   \_/    |_| \__||___/         \__,_||___/|_| |_| \__,_|         \___/  \__||_|  
                                                                                            ______                            ______                  
                                                                                           |______|                          |______|                 
EOF

echo " "

if [ "$EUID" -ne 0 ]; then
    echo "This script must be run with sudo."
    exit 1
fi 
echo "Running with sudo privileges."
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
echo "Do you want to automate the snapd daemon to start automatically with the boot process (yes/no)"
read -r answer

if [[ "$answer" =~ ^[Yy][Ee][Ss]$ ]]; then
	sudo systemctl enable snapd
 	sudo systemctl start snapd
 	sudo systemctl enable snapd.apparmor
  	sudo systemctl start snapd.apparmor
elif [[ "$answer" =~ ^[Nn][Oo]$ ]]; then
    echo "You chose not to automate."
else
    echo "Invalid input. Please enter 'yes' or 'no'."
fi

echo " "
echo "Linking Snapd to local application path"
#this will link snapd paths with local application paths 
ln -s /var/lib/snapd/desktop/applications ~/.local/share/applications/snap
echo " "
echo "Adding Snapd Binaries to System-Wide Enviroment Variables"
sudo sed -i '/^PATH=/ s|$|:/snap/bin|' /etc/environment
echo " "
echo "you might need to restart your system for the changes to take effect globally"


