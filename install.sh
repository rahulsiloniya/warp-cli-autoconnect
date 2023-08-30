declare -A osInfo;
osInfo[/etc/redhat-release]=yum
osInfo[/etc/arch-release]=pacman
osInfo[/etc/gentoo-release]=emerge
osInfo[/etc/SuSE-release]=zypp
osInfo[/etc/debian_version]=apt-get
osInfo[/etc/alpine-release]=apk

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
        echo Package manager: ${osInfo[$f]}
		pkgmgr=${osInfo[$f]}
		sudo "$pkgmgr" install shc

		shc -f ./warpfile.sh
		sudo mv warpfile.sh.x /usr/bin/warp-autoconnect
		sudo chmod +x /usr/bin/warp-autoconnect
		rm ./warpfile.sh.x.c
		break
    fi
done
