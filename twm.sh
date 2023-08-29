#!/bin/bash
FUNC=$1
#kwai ads
#_kwai () {
#	[[ "$FUNC" != "-boot" ]] && {
#		[[ -f $HOME/twm/.K && -s $HOME/twm/.K && $(cat $HOME/twm/.K) != $(date +%d) ]] && {
#		[[ $(cat $HOME/twm/.K 2> /dev/null) != $(date +%d) ]] && {
#			xdg-open $(echo aWt3YWk6Ly93ZWJ2aWV3P3VybD1odHRwcyUzQSUyRiUyRmluY2VudGl2ZS5rd2FpLmNvbSUyRmFjdGl2aXR5JTJGYm9vc3QlM0Z3ZWJ2aWV3JTNEeW9kYSUyNnNob3dMb2FkaW5nJTNEdHJ1ZSUyNm5lZWRMb2dpbiUzRHRydWUlMjZuZWVkX2xvZ2luJTNEdHJ1ZSUyNnNvdXJjZSUzRE9VVF9BUFAlMjZpbnZpdGVDb2RlJTNEQm9vc3Q2NjkyODExNjklMjZoeWxkJTNEaW5jZW50aXZlX21haW4lMjZjb3VudHJ5SW5mbyUzREJSJTI2bG9naW5DaGVjayUzRDElMjZfX2xvZ2luX3BhcmFtc19fJTNEJTI1N0IlMjUyMnNjaGVtZSUyNTIyJTI1M0ElMjUyMmlrd2FpJTI1M0ElMjUyRiUyNTJGbG9naW4lMjUyMiUyNTJDJTI1MjJsb2dpblR5cGUlMjUyMiUyNTNBMSUyNTdEJTI2X19sYXVuY2hfb3B0aW9uc19fJTNEJTI1N0IlMjUyMnRvcEJhclBvc2l0aW9uJTI1MjIlMjUzQSUyNTIyZml4ZWQlMjUyMiUyNTJDJTI1MjJlbmFibGVMb2FkaW5nJTI1MjIlMjUzQXRydWUlMjUyQyUyNTIybG9hZGluZ1R5cGUlMjUyMiUyNTNBJTI1MjJpbmNlbnRpdmVfaDUlMjUyMiUyNTdEJnRhcmdldF91cmw9aHR0cHMlM0ElMkYlMkZpbmNlbnRpdmUua3dhaS5jb20lMkZhY3Rpdml0eSUyRmJvb3N0LW91dHNpdGUtaW52aXRlJTNGd2VidmlldyUzRHlvZGElMjZzaGFyZV9pdGVtX3R5cGUlM0RoZWxwJTI2c2hhcmVfZGV2aWNlX2lkJTNEQU5EUk9JRF9mOGYyMTYyNzMxNTMzN2RlJTI2c2hhcmVfdWlkJTNEMTUwMDAwMjI0NDAyNzI5JTI2Y291bnRyeUluZm8lM0RCUiUyNmxhbmd1YWdlJTNEcHQtYnIlMjZzb3VydmVQbGF0Zm9ybSUzREFORFJPSUQlMjZjYyUzRGNvcHlsaW5rJTI2c2hhcmVfaWQlM0RBTkRST0lEX2Y4ZjIxNjI3MzE1MzM3ZGVfMTYzNTk0MTUwODkxMiUyNmZpc2hJZCUzRGJyLW90aGVyLWJvb3N0LTElMjZzaGFyZUVudGVyJTNEMSUyNmtwbiUzREtXQUkK | base64 -d)
#			echo $(date +%d) >$HOME/twm/.K
#		} || echo $(date +%d) >$HOME/twm/.K
#	}
#}
#_kwai
# /sync
[[ ! -z "$FUNC" ]] || {
	SERVER="https://raw.githubusercontent.com/sharesourcecode/twm/master"
	curl -s -L $SERVER/easyinstall.sh 2> /dev/null | cmp -s --bytes $((100 * 1024 * 1024)) $HOME/easyinstall.sh || {
		curl -s -O -L $SERVER/easyinstall.sh
		mv easyinstall.sh $HOME/easyinstall.sh 2>-
		SYNC=1
		. $HOME/easyinstall.sh
	}
}
echo -e "\e[01;30m\e[01;07m\n Starting...\n👉 Please wait...☕👴\e[00m"
echo "CgkbWzM0bRtbMDFt4pWU4pWQ4pWQ4pWX4pWU4pWX4pWU4pWQ4pWQ4pWX4pWU4pWQ4pWQ4pWX4pWU4pWQ4pWQ4pWX4pWU4pWQ4pWQ4pWXCgnilZrilZfilZTilZ3ilaDilaPilZrilZfilZTilZ3ilZHilZTilZfilZHilZHilZTilZfilZHilZHilZDilZDilaMKCV/ilZHilZEg4pWR4pWRIOKVkeKVkSDilZHilZTilZfilZHilZHilZHilZHilZHilaDilZDilZDilZEKCV/ilZrilZ0g4pWa4pWdIOKVmuKVnSDilZrilZ3ilZrilZ3ilZrilZ3ilZrilZ3ilZrilZDilZDilZ0KCQnilZTilabilZDilabilZfilZTilZDilZDilZfilZTilZDilZDilZcKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZrilZ3ilaMKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZHilZfilZEKCQnilZrilZDilanilZDilZ3ilZrilZ3ilZrilZ3ilZrilZ3ilZrilZ0KCQnilZTilZDilabilZDilZfilZTilZDilZDilZfilZTilZDilZDilZfilZTilZDilZDilZfilZTilZDilZDilZcKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZTilZDilZ3ilZHilZrilZ3ilaPilZHilZTilZfilZEKCQnilZHilZHilZHilZHilZHilZHilZTilZfilZHilZHilZrilZDilZfilZHilZHilZfilZHilZHilZrilZ3ilZEKCQnilZrilanilZDilanilZ3ilZrilZ3ilZrilZ3ilZrilZDilZDilZ3ilZrilZ3ilZrilZ3ilZrilZDilZDilZ0bWzAwbQpfX19fXxtbMzFtG1swMW3CqSB1ZWxpdG9uQGRpc3Jvb3Qub3JnIDIwMTkgLSAyMDIxG1swMG0KCg==" | base64 -d | sed 's,_,\ ,g'
sleep 2
# /termux
ls /data/data/com.termux/files/usr/share/doc &> /dev/null && {
	termux-wake-lock
	LS="/data/data/com.termux/files/usr/share/doc"
} || LS="/usr/share/doc"
# /w3m arguments
PAGE="w3m -cookie -o https_proxy=$PROXY"
DUMP="w3m -cookie -o https_proxy=$PROXY -dump"
SOURCE="w3m -cookie -o https_proxy=$PROXY -o accept_language=$LANG -o accept_encoding=UTF-8 -debug -dump_source"
# /colors
ww_='\e[01;36m\e[01;07m' # \e[01;30m\e[05;07m
_w_='\e[01;36m\e[08;07m'
rr_='\e[01;31m\e[01;07m'
gg_='\e[01;32m\e[01;07m'
y_='\033[33m\033'
yy_='\e[00;33m\e[01;07m'
bi_='\e[03;34m\e[02;03m'
b__='\e[03;34m\e[02;04m'
pp_='\e[01;35m\e[01;07m'
b_='\033[36m\033'
c_='\033[37m\033'
#cc_='\e[00m'
# /timeout
_timexit () {
	( for te in `seq ${@} -1 0`; do
		sleep 1
		grep -q -o $! <<<$(ps ax -o pid=,args=) || break 2> /dev/null
		[ $te == 1 ] && {
			kill -9 $! 2> /dev/null;
			echo -e "\033[31m\033[01mConnection error!\e[00m";
			break 2> /dev/null
		}
	done )
}
# /sources
cd ~/twm
#. clandmgfight.sh
. requeriments.sh ; . loginlogoff.sh
. flagfight.sh ; . clanid.sh ; . crono.sh ; . arena.sh ; . coliseum.sh
. campaign.sh ; . run.sh ; . altars.sh ; . clanfight.sh
. clancoliseum.sh ; . king.sh ; . undying.sh ; . clandungeon.sh
. trade.sh ; . career.sh ; . cave.sh ; . allies.sh ; . svproxy.sh
# /functions
_PLAY () {
	if [[ "$FUNC" == "-cv" ]] ; then
		PLAY="cv" && _cave
#	elif [[ "$FUNC" == "-cl" ]] ; then
#		PLAY="cl" && _coliseum
	else
		unset PLAY
		_play
	fi
}
_access () {
#	ENTER=$(grep -o -P '(/\w+/enterFight/\W+\w+\W+\d+)' $TMP/SRC)
#	ENTER=$(grep -o -P '(/\w+/enter\w{4,5}/\W+\w+\W+\d+)' $TMP/SRC)
	HLHP=$(echo $(($FULL * $HPER / 100)))
	ATK=$(sed -n 1p <<<$(grep -o -P '(/\w+/\w{0,4}at\w{0,3}k/\Wr\W\d+)' $TMP/SRC))
	ATKRND=$(grep -o -P '(/\w+/at\w{0,3}k\w{3,6}/\Wr\W\d+)' $TMP/SRC)
	DODGE=$(grep -o -P '(/\w+/d\w{4}/\Wr\W\d+)' $TMP/SRC)
	HEAL=$(grep -o -P '(/\w+/h\w{3}/\Wr\W\d+)' $TMP/SRC)
	stone=$(grep -o -P '(/\w+/stone/\Wr\W\d+)' $TMP/SRC)
	GRASS=$(grep -o -P '(/\w+/grass/\Wr\W\d+)' $TMP/SRC)
	SHIELD=$(grep -o -P '(/\w+/shield/\Wr\W\d+)' $TMP/SRC)
	DT=$(grep -o -P '\d{2}:\d{2}' <<<$(grep -o -P 'dodge(.*)dgreen medium\D{2}00:(0|1|2)\d{1}(.*)/at' $TMP/SRC | tail -n1))
	HT=$(grep -m1 -o -P '\d{2}:\d{2}' <<<$(grep -o -P '\Wheal\W(.*)\d{1,2}:\d{2}(.*)/stone/' $TMP/SRC | tail -n1))
	ST=$(grep -o -P '\d{2}:\d{2}' <<<$(grep -o -P '/stone/(.*)00:\d{2}(.*)/grass/' $TMP/SRC | tail -n1))
	GT=$(grep -o -P '\d{2}:\d{2}' <<<$(grep -o -P '/grass/(.*)00:\d{2}(.*)/\w+/' $TMP/SRC | tail -n1))
	CT=$(sed -n 1p <<<$(grep -o '[0-9][0-9]\:[0-9][0-9]' $TMP/SRC))
	BEXIT=$(grep -o 'user.png' $TMP/SRC)
	OUTGATE=$(grep -o 'out_gate' $TMP/SRC)
	LEAVEFIGHT=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/leaveFight/' | head -n1 | awk -F"[']" '{ print $2 }')
	WDRED=$(cat $TMP/SRC | sed "s/alt/\\n/g" | grep 'hp' | head -n1 | awk -F"[']" '{ print $4 }') #white/dred
	_show
}
_unset () {
	unset HP1 HP2 YOU USER CLAN ENTER ENTER ATK ATKRND DODGE HEAL BEXIT OUTGATE LEAVEFIGHT WDRED HLHP
}
[[ -f $HOME/twm/.UR && -s $HOME/twm/.UR ]] && {
	echo -e "\033[32m\033\ Starting with last settings used.\033[00m"
	num=6
	for i in `seq 6 -1 1` ; do
		i=$[$i-1]
		read -t1 && {
			>$HOME/twm/.AL
			>$HOME/twm/.UR
			>$HOME/twm/.UA
			unset UR
			unset UA
			unset AL
			break
		}
		echo -e " Hit\033[33m\033\ [Enter]\033[00m to\033[33m\033\ reconfigure\033[32m\033\ "$i"s\e[00m"
	done
}
_requeriments
_proxy
_msgs () {
	echo -e "\ ##### mail #####" > $TMP/msgs.txt
	( exec $PAGE $URL/mail -o user_agent="$(shuf -n1 .ua)" | tee $TMP/info.txt | sed -n '/[|]\ mp/,/\[arrow\]/p' | sed '1,1d;$d;6q' >> $TMP/msgs.txt ) &
	_timexit 10
	echo -e "##### chat titans #####" >> $TMP/msgs.txt
	( exec $PAGE $URL/chat/titans/changeRoom -o user_agent="$(shuf -n1 .ua)" | sed -n '/\(\»\)/,/\[chat\]/p' | sed '$d;4q' >> $TMP/msgs.txt ) &
	_timexit 10
	echo -e "##### chat clan #####" >> $TMP/msgs.txt
	( exec $PAGE $URL/chat/clan/changeRoom -o user_agent="$(shuf -n1 .ua)" | sed -ne '/\[[^a-z]\]/,/\[chat\]/p' | sed '$d;4q' >> $TMP/msgs.txt ) &
	_timexit 10
# lvl | g | s
#	sed ':a;N;s/\n//g;ta' |
	sed 's/lvl/\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ lvl/g;s/g/\ g/g;s/s/\ s/g' <<<$(grep -o -P '(lvl\ \d{1,2}\ \|\ g\ \d{1,3}\D{0,1}\d{0,3}\w{0,1}\ \|\ s\ \d{1,3}\D{0,1}\d{0,3}\w{0,1})' $TMP/info.txt) >> $TMP/msgs.txt
}
_loginlogoff
[[ -n $ALLIES ]] && _alliesConf
ts=20
while true ;
do
	rpt=$[$rpt+1]
	sleep 1
	if [[ $rpt -ne 1 ]] ;
	then
		ts=20
	fi
	_PLAY
done
unset rpt ts
kill -9 $$
exit
