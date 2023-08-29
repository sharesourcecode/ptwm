#!/bin/bash
#openssl enc -e -aes-256-cbc -a -pbkdf2 -in sourceinstall.sh > install
echo -e "\e[01;36m\e[01;07m\n Wait for the scripts to download...☕👴\e[00m"
cd ~/twm
_sync () {
	token=$(echo "ZGNiMmY1NjM1OTZmNmQyNmMxYjRkNGU2ZmUxY2MzODU5ZGUyMjg2Ygo=" | base64 -d)
#	SERVER="https://$token@raw.githubusercontent.com/sharesourcecode/ptwm/master"
	SERVER="https://$token@codeberg.org/ueliton/ptwm/raw/branch/master/"
# /sync array scripts
	SCRIPTS=(allies.sh altars.sh arena.sh campaign.sh career.sh cave.sh clancoliseum.sh clandungeon.sh clanfight.sh clanid.sh coliseum.sh crono.sh flagfight.sh king.sh loginlogoff.sh play.sh requeriments.sh run.sh svproxy.sh trade.sh undying.sh)
	for s in "${SCRIPTS[@]}"; do
		num=$[$num+1]
		echo -e " Checking $num/${#SCRIPTS[*]} $s"
		curl -L -s $SERVER/$s 2> /dev/null | cmp -s --bytes $((100 * 1024 * 1024)) $s || {
			[[ -e ~/twm/$s ]] && {
				rm "$s" &> /dev/null
				echo -e "\e[01;32m\e[01;07m Updating $s\e[00m"
			} || {
				echo -e "\e[00;33m\e[01;07m Downloading $s\e[00m"
			}
			curl -q $SERVER/$s -O -L &> /dev/null
		}
		sleep 1s
	done
	echo -e "\e[01;32m\e[01;07m Building binary...\e[00m"
	cd ~/twm
	rm -rf ~/twm/twm.run &> /dev/null
	curl -q $SERVER/twm.sh -O -L &> /dev/null
	unset token
	shc -r -e "22/2/2022" -m "Suporte pelo email ueliton@disroot.org" -f twm.sh &> /dev/null
	mv ~/twm/twm.sh.x ~/twm/twm.run
	rm -rf ~/twm/twm.sh.x.c &> /dev/null
	rm -rf ~/twm/twm.sh &> /dev/null
	unset SCRIPTS s num SERVER
# /DOS to Unix
	sed -i 's/^M$//g' ~/twm/*.sh &> /dev/null
	sed -i 's/\x0D$//g' ~/twm/*.sh &> /dev/null
	chmod +x ~/twm/*.sh &> /dev/null
	chmod +x ~/twm/twm.run &> /dev/null
}
_sync
echo "CgkbWzM0bRtbMDFt4pWU4pWQ4pWQ4pWX4pWU4pWX4pWU4pWQ4pWQ4pWX4pWU4pWQ4pWQ4pWX4pWU4pWQ4pWQ4pWX4pWU4pWQ4pWQ4pWXCgnilZrilZfilZTilZ3ilaDilaPilZrilZfilZTilZ3ilZHilZTilZfilZHilZHilZTilZfilZHilZHilZDilZDilaMKCV/ilZHilZEg4pWR4pWRIOKVkeKVkSDilZHilZTilZfilZHilZHilZHilZHilZHilaDilZDilZDilZEKCV/ilZrilZ0g4pWa4pWdIOKVmuKVnSDilZrilZ3ilZrilZ3ilZrilZ3ilZrilZ3ilZrilZDilZDilZ0KCQnilZTilabilZDilabilZfilZTilZDilZDilZfilZTilZDilZDilZcKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZrilZ3ilaMKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZHilZfilZEKCQnilZrilZDilanilZDilZ3ilZrilZ3ilZrilZ3ilZrilZ3ilZrilZ0KCQnilZTilZDilabilZDilZfilZTilZDilZDilZfilZTilZDilZDilZfilZTilZDilZDilZfilZTilZDilZDilZcKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZTilZDilZ3ilZHilZrilZ3ilaPilZHilZTilZfilZEKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZrilZDilZfilZHilZHilZfilZHilZHilZrilZ3ilZEKCQnilZrilanilZDilanilZ3ilZrilZ3ilZrilZ3ilZrilZDilZDilZ3ilZrilZ3ilZrilZ3ilZrilZDilZDilZ0bWzAwbQpfX19fXxtbMzFtG1swMW3CqSB1ZWxpdG9uQGRpc3Jvb3Qub3JnIDIwMTkgLSAyMDIxG1swMG0KCg==" | base64 -d | sed 's,_,\ ,g'
echo -e "\e[01;32m\e[01;07mUpdated scripts!\e[00m\n To execute run command: \033[33mbash twm/play.sh\e[00m\n\ For cave run: \033[33mbash twm/play.sh -cv\e[00m\n\ For coliseum run: \033[33mbash twm/play.sh -cl\e[00m"
pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -P '(\d{3,5})')
until [[ -z $pidf ]] ; do
	kill -9 $pidf 2> /dev/null
	pidf=$(ps ax -o pid=,args= | grep 'twm/play.sh' | grep -v 'grep' | head -n1 | grep -o -P '(\d{3,5})')
	sleep 1s
done
pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -P '(\d{3,5})')
until [[ -z $pidf ]] ; do
	kill -9 $pidf 2> /dev/null
	pidf=$(ps ax -o pid=,args= | grep 'twm/twm.sh' | grep -v 'grep' | head -n1 | grep -o -P '(\d{3,5})')
	sleep 1s
done
[[ -f ~/twm/RUN ]] && {
	if [[ $(cat ~/twm/RUN) == "cl" ]] ; then
		echo -e "\e[01;32m\e[01;07mAutomatically restarting in 5s after update...\e[00m"
		sleep 5s
		~/twm/play.sh -cl
	elif [[ $(cat ~/twm/RUN) == "cv" ]] ; then
		echo -e "\e[01;32m\e[01;07mAutomatically restarting in 5s after update...\e[00m"
		sleep 5s
		~/twm/play.sh -cv
	else
		echo -e "\e[01;32m\e[01;07mAutomatically restarting in 5s after update...\e[00m"
		sleep 5s
		~/twm/play.sh
	fi
}
