#!/bin/bash
echo "start of install_inotify-tools.sh------------------------------------"
echo "running install_inotify-tools.sh"
haveProg() {
    command -v "$1"
}

pacmans=("apt" "dnf" "yum" "pacman" "zypper" "apk")
for prog in "${pacmans[@]}"; do
	if haveProg "$prog"; then
		echo "$prog found"
		break
	fi
done

echo "end of install_inotify-tools.sh--------------------------------------"

