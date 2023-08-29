# /arena
#http://furiadetitas.net/marathon/take/?r=41422587
_openChest () {
	echo "openChest ..."
	( exec $SOURCE  "$URL/quest" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
	BREAK=$(echo $(( `date +%M` + 1 )))
	while [[ -n $ACCESS ]]; do
		[[ $(date +%M) = $BREAK ]] && break
		( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		echo $ACCESS
		ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep 'quest/openChest' | head -n1 | awk -F\' '{ print $2 }')
		sleep 1s
	done
	unset ACCESS
	echo -e "openChest (✔)\n"
}
_fault () {
	( exec $SOURCE  "$URL/fault" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	BREAK=$(echo $(( `date +%M` + 2 )))
	while $(grep -q '/fault/attack' $TMP/SRC) ; do
		[[ $(date +%M) = $BREAK ]] && break
		ACCESS=$(sed -n '1p' <<<$(grep -o -P '(/fault/attack/\Wr\W\d+)' $TMP/SRC))
		( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		echo $ACCESS
		sleep 1s
	done
#	grep -q '/fault/' $TMP/SRC && {
#		echo "fault ..."
#		ACCESS=$(sed -n 1p <<<$(grep -o -P '(/fault(/attack/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
#		echo $ACCESS
#		BREAK=$(echo $(( `date +%M` + 2 )))
#		while [[ -n $ACCESS ]]; do
#			grep -q -o "/arena" $TMP/SRC && {
#				break &> /dev/null
#			} || {
#				( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
#				_timexit 10
#				echo $ACCESS
#				ACCESS=$(sed -n 1p <<<$(grep -o -P '(/fault(/attack/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
#			}
#		done
		unset ACCESS
		echo -e "fault (✔)\n"
#	}
}
_colifight () {
	( exec $SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	grep -q -o '/collfight/' $TMP/SRC && {
		echo "collfight ..."
		echo "/collfight/enterFight"
		ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep 'collfight/take' | head -n1 | awk -F\' '{ print $2 }')
		( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "$ACCESS"
		( exec $SOURCE "$URL/collfight/enterFight" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/collfight/enterFight"
		unset ACCESS
		echo -e "collfight (✔)\n"
	}
}
_AtakeHelp () {
	_clanid
	if [[ -n $CLD ]]; then
		( exec $DUMP "$URL/clan/$CLD/quest/take/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/take/3"
		( exec $DUMP "$URL/clan/$CLD/quest/help/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/help/3"
		( exec $DUMP "$URL/clan/$CLD/quest/take/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/take/4"
		( exec $DUMP "$URL/clan/$CLD/quest/help/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/help/4"
	fi
	unset CLD
}
_AdeleteEnd () {
	_clanid
	if [[ -n $CLD ]]; then
		( exec $DUMP "$URL/clan/$CLD/quest/deleteHelp/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/deleteHelp/3"
		( exec $DUMP "$URL/clan/$CLD/quest/end/3" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/end/3"
		( exec $DUMP "$URL/clan/$CLD/quest/deleteHelp/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/deleteHelp/4"
		( exec $DUMP "$URL/clan/$CLD/quest/end/4" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/end/4"
	fi
	unset CLD
}
_arena () {
	_colifight
	_fault
	echo "arena ..."
	_AtakeHelp
	( exec $SOURCE "$URL/arena/" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	BREAK=$(echo $(( `date +%M` + 2 )))
	until $(grep -q 'lab/wizard' $TMP/SRC) ; do
		[[ $(date +%M) = $BREAK ]] && break
		ACCESS=$(sed -n '1p' <<<$(grep -o -P '(/arena/attack/1/\Wr\W\d+)' $TMP/SRC)) #/arena/attack/1/1234567*/
		( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		echo "$ACCESS"
		sleep 1s
	done
	unset ACCESS EXIT
	_AdeleteEnd
	echo -e "arena (✔)\n"
}
_fullmana () {
	echo "energy arena ..."
	( exec $SOURCE $URL/arena/quit -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "attack/1" | head -n1 | awk -F\/ '{ print $5 }' | tr -cd "[[:digit:]]" >ARENA ) &
	_timexit 10
	echo " ⚔ - 1 Attack..."
	( exec $SOURCE "$URL/arena/attack/1/?r=`cat ARENA`" -o user_agent="$(shuf -n1 .ua)" | sed "s/href='/\n/g" | grep "arena/lastPlayer" | head -n1 | awk -F\' '{ print $1 }' | tr -cd "[[:digit:]]" >ATK1 ) &
	_timexit 10
	echo " ⚔ - Full Attack..."
	( exec $DUMP "$URL/arena/lastPlayer/?r=`cat ATK1`&fullmana=true" -o user_agent="$(shuf -n1 .ua)" | head -n5 | tail -n4 ) &
	_timexit 10
	echo -e "energy arena (✔)\n"
}
