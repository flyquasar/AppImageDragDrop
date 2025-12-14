#!/bin/bash
#Perform preflight checks---------------------------------------------
dir=~/Applications/
icons=~/Applications/.icons/
file=~/autoAppsInstall.service

targetdir="$HOME/scripts/AppImageDragDrop"
targetdir=$(realpath -m "$targetdir")

# Get the directory where the script itself resides
script_dir="$(dirname "$(realpath "$0")")"

if [ "$script_dir" != "$targetdir" ]; then
    echo "Moving AppImageDragDrop folder to $targetdir..."
    mkdir -p "$(dirname "$targetdir")"
    mv "$script_dir" "$targetdir"
    echo "Folder moved to $targetdir. Please run the script from there."
    exec "$targetdir/AppImageDragDrop.sh" "$@"
fi

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