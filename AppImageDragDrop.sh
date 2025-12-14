#!/bin/bash
if [ "$1" = "remove" ];then
	echo "removing service file and icons"
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

inotifywait -m -e close_write -e "moved_to" "$dir" |
	while read -r directory event file; do
		if [[ "$file" == *.AppImage ]]; then
		echo "New AppImage fully written: $file"
		# safe to extract and copy icons here
		basename="${file%.*}"
		#mount appimage to extract
		cd $dir
		./$file --appimage-extract
		cp squashfs-root/*.png $dir.icons/$basename.png
		rm -rf squashfs-root
		#end appimage extract

		echo "Adding +x permission to $dir$file"
		chmod +x "$dir/$file"
		cat > ~/.local/share/applications/"$basename".desktop << EOF
[Desktop Entry]
Version=1.0
Icon=$dir.icons/$basename.png
Type=Application
Name=$basename
Exec=$dir$file
EOF
		fi
	done
