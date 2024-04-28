#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
    echo "This script must be run as root."
    exit 1
fi

echo "BurpInstaller By Ashu"

echo " "

echo "Make sure to active burpsuite proffesional Before Running this script"

echo " "

echo "Making Directory for BurpSuite Proffesional...."

sudo mkdir /usr/bin/burpsuite_pro

echo " "

echo "Moving Files to the new burpsuite_pro Directory"

sudo mv *.jar /usr/bin 

echo "Changing Directory...."

cd /usr/bin/burpsuite_pro

echo " "

echo "Defining Custom Script to launch BurpSuite Proffesional"

sudo echo -e '#!/bin/bash\necho "Burploader By Ashu"\n"/usr/lib/jvm/java-21-openjdk-amd64/bin/java" "--add-opens=java.desktop/javax.swing=ALL-UNNAMED" "--add-opens=java.base/java>' >> burp.sh

echo " "

echo "Giving Executable Permissions to the Script..."

sudo chmod +x burp.sh

echo ""

echo "Making BurpsuitePro & Burploader Executable...."

sudo chmod +x *.jar

echo " "

echo "Linking Directories and Adding Custom Alias to Launch BurpSuite Proffesional"

sudo ln -sf /usr/bin/burpsuite_pro/burp.sh /usr/local/bin/burp

echo "Done !"

echo " "

echo "Now you can type "burp" in your terminal to launch BurpSuite Proffesional Directly....."
