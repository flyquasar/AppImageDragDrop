#!/bin/bash
#Perform preflight checks---------------------------------------------
dir=~/Applications/
icons=~/Applications/.icons/
file=~/autoAppsInstall.service

if [ -d $dir ] && [ -d $icons ];then
	echo "It exists nothing else to be done."
else
	mkdir ~/Applications
	mkdir ~/Applications/.icons
	echo "Needed to make folders in"
	ls -l ~ |  grep Applications
fi

if [ -f $file ];then
	echo "Service file found"
else
	echo "Preping service.."
	touch ~/autoAppsInstall.service
cat > ~/autoAppsInstall.service << EOF
writting to file..
EOF
##TO DO: Add actual service content later - create another bash script
        echo "Prepared."
fi

##run sub script to install inotify-tools if not present
#---------------------------------------------------
source sub_scripts/install_inotify-tools.sh
echo $testvar
#---------------------------------------------------

#End Perform preflight checks---------------------------------------------