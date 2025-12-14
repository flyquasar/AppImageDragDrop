#!/bin/bash
#Perform preflight checks---------------------------------------------
dir=$HOME/Applications/
icons=$HOME/Applications/.icons/
service_file=$HOME/.config/systemd/user/autoAppImageInstall.service

targetdir="$HOME/scripts/AppImageDragDrop"
targetdir=$(realpath -m "$targetdir")

# Get the directory where the script itself resides
script_dir="$(dirname "$(realpath "$0")")"

if [ "$script_dir" != "$targetdir" ]; then
    echo "Moving AppImageDragDrop folder to $targetdir..."
    mkdir -p "$(dirname "$targetdir")"
    mv "$script_dir" "$targetdir"
    echo "Folder moved to $targetdir."
    exec "$targetdir/AppImageDragDrop.sh" "$@"
fi

if [ -d $dir ] && [ -d $icons ];then
	echo "Needed folders found."
else
	mkdir $HOME/Applications
	mkdir $HOME/Applications/.icons
	echo "Needed to make folders in"
	ls -l $HOME |  grep Applications
fi

if [ -f $service_file ];then
	echo "Service file found"
else
	echo "Preping service.."
cat > $HOME/.config/systemd/user/autoAppImageInstall.service << EOF
[Unit]
Description=service to auto install AppImages dropped in Applications folder
After=default.target
[Service]
WorkingDirectory=%h/scripts/AppImageDragDrop
ExecStart=%h/scripts/AppImageDragDrop/AppImageDragDrop.sh runner
Restart=always
RestartSec=5
[Install]
WantedBy=default.target
EOF
#------------------------------------------

# Reload systemd to pick up the new unit
systemctl --user daemon-reload

# Enable the service (start on login)
systemctl --user enable autoAppImageInstall.service

# Start the service immediately
systemctl --user start autoAppImageInstall.service

echo "Service autoAppImageInstall.service enabled and started."
echo "It will now run automatically at user login."
        echo "Prepared."
fi

##run sub script to install inotify-tools if not present
#---------------------------------------------------
source sub_scripts/install_inotify-tools.sh
#---------------------------------------------------

#End Perform preflight checks---------------------------------------------