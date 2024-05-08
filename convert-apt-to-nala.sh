#!/bin/bash
echo " "
echo "Convert Apt to Nala"
echo " By @its_ashu_otf "
echo " "
echo "Installing Nala......"
echo " "
sudo apt update && sudo apt install nala
echo "Done !"
echo " "
echo "Updating Nala Mirrors"
echo " "
sudo nala fetch
echo " "
echo "Adding Nala to .zshrc to convert APT to Nala"

echo 'apt() { 
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}' >> ~/.zshrc

echo " "
echo "Adding Nala to .bashrc to convert APT to Nala"

echo 'apt() { 
  command nala "$@"
}
sudo() {
  if [ "$1" = "apt" ]; then
    shift
    command sudo nala "$@"
  else
    command sudo "$@"
  fi
}' >> ~/.bashrc


echo " "
echo "Sourcing the zshrc & bashrc file"
source ~/.zshrc
source ~/.bashrc
echo " "
echo " "
echo "Done ! Now you can install programs with apt or nala command and it will always work perfectly!"
