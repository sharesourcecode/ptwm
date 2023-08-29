#!/bin/bash
key=13
cd ~/
if [ $(curl -s -q -L "https://raw.githubusercontent.com/sharesourcecode/twm/master/check") = $(wc -m $HOME/easyinstall.sh | grep -o -P "\d+") ] ; then
	echo -e "\e[01;36m\e[01;07m\n Upgrading...\n👉 Please wait...☕👴\e[00m"
# /OS packages
# /termux
	ls /data/data/com.termux/files/usr/share/doc &> /dev/null && {
		termux-wake-lock
		sed -i '/nameserver/d' $PREFIX/etc/resolv.conf &> /dev/null
		echo -e "nameserver 1.1.1.1\nnameserver 8.8.8.8" >$PREFIX/etc/resolv.conf
		LS="/data/data/com.termux/files/usr/share/doc"
		#cp -R twm/ storage/downloads/twm
		rm -rf ~/.termux/boot/play.sh 2> /dev/null
		mkdir -p ~/.termux/boot
		echo "IyEvZGF0YS9kYXRhL2NvbS50ZXJtdXgvZmlsZXMvdXNyL2Jpbi9zaApiYXNoICRIT01FL3R3bS9wbGF5LnNoIC1ib290Cg==" | base64 -d >~/.termux/boot/play.sh 2> /dev/null
		chmod +x ~/.termux/boot/play.sh 2> /dev/null
		ls "$LS" | grep -q "termux-api" || pkg install termux-api -y
		ls "$LS" | grep -q w3m || pkg install w3m -y
		pkg search ncurses-utils 2>/dev/null | grep -q installed || pkg install ncurses-utils -y
		ls "$LS" | grep -q openssl || pkg install openssl -y
		pkg search openssl-tool 2>/dev/null | grep -q installed || pkg install openssl-tool -y
		ls "$LS" | grep -q shc || pkg install shc -y
		ls "$LS" | grep -q coreutils || pkg install coreutils -y
		ls "$LS" | grep -q dnsutils || pkg install dnsutils -y
		ls "$LS" | grep -q procps || pkg install procps -y
	}
# /cygwin
	uname | grep -q -i cygwin && {
		LS="/usr/share/doc"
		ls /bin | grep -q apt-cyg || {
			curl -q -L -O "http://raw.githubusercontent.com/sharesourcecode/apt-cyg/master/apt-cyg" &> /dev/null
			install apt-cyg /bin
		}
		ls "$LS" | grep -q w3m || apt-cyg install w3m -y &> /dev/null
		ls "$LS" | grep -q openssl || apt-cyg install openssl -y &> /dev/null
		apt-cyg install openssl-tool -y &> /dev/null
		ls "$LS" | grep -q shc || apt-cyg install shc -y &> /dev/null
		ls "$LS" | grep -q ncurses-term || apt-cyg install ncurses-term -y &> /dev/null
		ls "$LS" | grep -q coreutils || apt-cyg install coreutils -y &> /dev/null
		ls "$LS" | grep -q dnsutils || apt-cyg install dnsutils -y &> /dev/null
		ls "$LS" | grep -q procps || apt-cyg install procps -y &> /dev/null
	}
# /linux
	uname -o | grep -q -i GNU/Linux && {
		LS="/usr/share/doc"
		echo -e "Please install with:\nsudo apt update\n sudo apt install openssl openssl-tool shc coreutils ncurses-term procps w3m dnsutils -y"
		sleep 10s
	}
	unset LS
# /twm dir
	mkdir -p ~/twm
	cd ~/twm
	curl -q -L -O "https://raw.githubusercontent.com/sharesourcecode/twm/master/install" &> /dev/null
	echo -e "\e[00;33m\e[01;07m Type $key:\e[00m"
	openssl enc -d -aes-256-cbc -a -pbkdf2 -in install | bash -
else
	cd ~/
	curl -q -L -O "https://raw.githubusercontent.com/sharesourcecode/twm/master/easyinstall.sh" &> /dev/null
	echo "Mistake! Try again later."
fi
