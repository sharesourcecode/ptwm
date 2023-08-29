# /trade
_trade () {
	echo "trade ..."
	( exec $SOURCE "$URL/trade/exchange" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	ACCESS=$(cat $TMP/SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
	EXIST=$(cat $TMP/SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
	BREAK=$(echo $(( `date +%M` + 2 )))
	while [[ -n $EXIST ]]; do
		[[ $(date +%M) = $BREAK ]] && break
		echo -e "/trade/exchange/silver/1?r=$ACCESS"
		( exec $SOURCE "$URL/trade/exchange/silver/1?r=$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		ACCESS=$(cat $TMP/SRC | sed "s/\/trade/\\n/g" | grep 'exchange'| grep 'silver/1' | head -n1 | awk -F\= '{ print $2 }' | awk -F\' '{ print $1 }')
		EXIST=$(cat $TMP/SRC | sed "s/\/trade/\\n/g" | grep 'exchange' | grep 'silver/1' | head -n1 | awk -F\/ '{ print $3 }')
		sleep 1s
	done
	unset ACCESS EXIST
	echo -e "trade (✔)\n"
}
_money () {
	_clanid
	if [[ -n $CLD ]] ; then
		echo -e "clan money ..."
		( exec $SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]" >$TMP/CODE ) &
		_timexit 10
		echo -e "/clan/$CLD/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit"
		( exec $PAGE "$URL/clan/$CLD/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		( exec $SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]" >$TMP/CODE ) &
		_timexit 10
		echo -e "/clan/$CLD/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit"
		( exec $PAGE "$URL/clan/$CLD/money/?r=`cat $TMP/CODE`&silver=1000&gold=0&confirm=true&type=limit" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		echo -e "clan money (✔)\n"
	fi
}
_built () {
	_clanid
	if [[ -n $CLD ]] ; then
		echo -e "clan built ..."
		( exec $SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]" >$TMP/CODE ) &
		_timexit 10
		( exec $PAGE "$URL/clan/$CLD/built/?goldUpgrade=true&r=`cat $TMP/CODE`" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		echo -e "/clan/$CLD/built/?goldUpgrade=true&r=`cat $TMP/CODE`"
		( exec $SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]" >$TMP/CODE ) &
		_timexit 10
		( exec $PAGE "$URL/clan/$CLD/built/?silverUpgrade=true&r=`cat $TMP/CODE`" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		echo -e "/clan/$CLD/built/?silverUpgrade=true&r=`cat $TMP/CODE`"
		echo -e "clan built (✔)\n"
	fi
}
