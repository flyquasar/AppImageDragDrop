#!/bin/bash
if [ "$1" = "remove" ];then
	echo "removing service file and disabling service..."
	systemctl --user stop autoAppImageInstall.service
	systemctl --user disable autoAppImageInstall.service
	rm $HOME/.config/systemd/user/autoAppImageInstall.service
	systemctl --user daemon-reload
	exit 0
fi
## Perform preflight checks---------------------------------------------
	source sub_scripts/pre_flight_script.sh
## End Perform preflight checks---------------------------------------------

if [ "$1" != "runner" ];then
	echo "Script ran as installation/preparation mode."
	echo "Complete."
	echo "Exiting now."
	exit 0
fi

inotifywait -m -e close_write -e moved_to -e delete -e moved_from "$dir" |
while read -r directory event file; do
    if [[ "$file" == *.AppImage ]]; then
        basename="${file%.*}"

        if [[ "$event" == *"CLOSE_WRITE"* || "$event" == *"MOVED_TO"* ]]; then
            echo "New AppImage detected: $file"
            cd "$dir"
			echo "Adding +x permission to $dir$file"
            chmod +x $file
            ./$file --appimage-extract
            #-----get .desktop
            desktopname=$(ls squashfs-root | grep .desktop)
            category=$(cat squashfs-root/$desktopname | grep Categories=)
            dsk=$(cat squashfs-root/$desktopname | grep Name=)
            echo $desktopname
            echo $dsk
            echo $category
            #-----------------
            cp squashfs-root/*.png "$dir.icons/$basename.png"
            rm -rf squashfs-root

            cat > ~/.local/share/applications/"$basename".desktop << EOF
[Desktop Entry]
Version=1.0
Icon=$dir.icons/$basename.png
Type=Application
$dsk
$category
Exec=$dir$file
EOF
        elif [[ "$event" == *"DELETE"* || "$event" == *"MOVED_FROM"* ]]; then
            echo "AppImage removed: $file"
            rm -f ~/.local/share/applications/"$basename".desktop
            rm -f $dir.icons/$basename.png
        fi
    fi
done

