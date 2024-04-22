#!/bin/bash
echo " "
echo "Convert Apt to Nala"
echo " By @its_ashu_otf "
echo " "
echo "Adding Repository"
echo "deb http://deb.volian.org/volian/ scar main" | sudo tee /etc/apt/sources.list.d/volian-archive-scar-unstable.list; wget -qO - https://deb.volian.org/volian/scar.key | sudo tee /etc/apt/trusted.gpg.d/volian-archive-scar-unstable.gpg
echo " "
echo "Done !"
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

sed -i '$ a\
\napt() { \
\n  command nala "$@" \
\n} \
\nsudo() { \
\n  if [ "$1" = "apt" ]; then \
\n    shift \
\n    command sudo nala "$@" \
\n  else \
\n    command sudo "$@" \
\n  fi \
\n}' ~/.zshrc
echo " "
echo "Adding Nala to .bashrc to convert APT to Nala"
sed -i '$ a\
\napt() { \
\n  command nala "$@" \
\n} \
\nsudo() { \
\n  if [ "$1" = "apt" ]; then \
\n    shift \
\n    command sudo nala "$@" \
\n  else \
\n    command sudo "$@" \
\n  fi \
\n}' ~/.bashrc

echo " "
echo "Sourcing the zshrc & bashrc file"
source ~/.zshrc
source ~/.bashrc
echo " "
echo " "
echo "Done ! Now you can install programs with apt or nala command and it will always work perfectly!"
