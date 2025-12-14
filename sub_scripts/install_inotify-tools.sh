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
if command -v inotifywait >/dev/null 2>&1; then
    echo "inotify-tools already installed."
else
	echo "inotify-tools not found. Installing..."
	case "$prog" in
		apt)
			sudo apt install -y inotify-tools
			;;
		dnf)
			sudo dnf install inotify-tools
			;;
		yum)
			sudo yum install -y inotify-tools
			;;
		pacman)
			sudo pacman -Sy inotify-tools --noconfirm
			;;
		zypper)
			sudo zypper install -y inotify-tools
			;;
		apk)
			sudo apk add inotify-tools
			;;
		*)
			echo "No supported package manager found. Please install inotify-tools manually."
			;;
	esac
fi

echo "end of install_inotify-tools.sh--------------------------------------"

