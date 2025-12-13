#!/bin/bash
dir=~/Applications/
icons=~/Applications/.icons/
file=~/autoAppsInstall.service
#Perform preflight checks---------------------------------------------
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
        echo "Prepared."
fi


# haveProg() {
#     command -v "$1"
# }

# pacmans=("apt" "dnf" "yum" "pacman" "zypper" "apk")
# for prog in "${pacmans[@]}"; do
# 	if haveProg "$prog"; then
# 		echo "$prog found"
# 		break
# 	fi
# done

chmod +x sub_scripts/install_inotify-tools.sh
sub_scripts/install_inotify-tools.sh

#End Perform preflight checks---------------------------------------------

if [ ! -f $dir.oldlist ];then
	echo "not found"
	#touch $dir.oldlist
	echo "made old list"
	ls $dir > $dir.oldlist

else
	echo "old list found"
	echo "___________"
	echo "creating updated list"
	ls $dir > $dir.newlist

	mapfile -t differences < <(diff $dir.oldlist $dir.newlist)
	if [ ${#differences[@]} -eq 0 ]; then
			echo "No changes detected between oldlist and newlist."
			rm $dir.newlist
		else
			echo "Changes detected..."
		for line in "${differences[@]}"; do
			if [[ "$line" =~ ^\<\ (.*) ]]; then
				file="${BASH_REMATCH[1]}"
			elif [[ "$line" =~ ^\>\ (.*) ]]; then
				file="${BASH_REMATCH[1]}"
			else
				continue
			fi
			basename="${file%.*}"
			#mount appimage to extract
			cd $dir
			./$file --appimage-extract
			cp squashfs-root/*.png $dir.icons/$basename.png
			rm -rf squashfs-root
			#end appimage extract
			
			echo "Adding +x permission to $dir$file"
			chmod +x "$dir/$file"
			touch ~/.local/share/applications/"$basename".desktop
			cat > ~/.local/share/applications/"$basename".desktop << EOF
[Desktop Entry]
Version=1.0
Icon=$dir.icons/$basename.png
Type=Application
Name=$basename
Exec=$dir$file
EOF
		done
		echo "Updating oldlist"
		mv $dir.newlist $dir.oldlist
	fi
fi


