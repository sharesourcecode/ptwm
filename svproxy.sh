_proxy () {
	ls "$LS" | grep -q dnsutils && {
#Obtains proxy.
		SPROXY=$(dig $URL | grep -o -P '(\d+.\d+.\d+.\d+.\d+)' | sed -n 's/^.*$/&:443/;1p')
		PROXY="https://$SPROXY"
		unset SPROXY
	} || {
		if [[ $UR == $'\0' || $UR == 3 ]]; then
			PROXY="https://176.9.21.20:443"
		elif [[ $UR == 0 || $UR == 1 || $UR -ge 4 ]]; then
			PROXY="https://138.201.178.183:443"
		elif [[ $UR == 2 ]]; then
			PROXY="https://148.251.244.27:443"
		fi
	}
	echo -e "\e[01;30m\e[01;07m Server: $URL|$PROXY \e[00m"
	unset LS UR
#Use w3m -o http_proxy=$PROXY $URL...
}
