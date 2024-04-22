#!/bin/bash
echo "Fix for VMware Blacklisted Drivers"
echo " " 
echo "Editing the config"
sed -i '/^mks.gl.allowBlacklistedDrivers/d' ~/.vmware/preferences && echo 'mks.gl.allowBlacklistedDrivers = "TRUE"' >> ~/.vmware/preferences
echo ""
echo "Done ! Restart your VMware. It Should Now Be Fixed "
