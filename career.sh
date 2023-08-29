# /career
# /career/attack/?r=8781779
_career () {
	echo "career ..."
	_clanid
	[[ -n $CLD ]] && {
#		( exec $PAGE "$URL/clan/$CLD/quest/take/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
#		_timexit 10
#		echo "/clan/$CLD/quest/take/6"
		( exec $PAGE "$URL/clan/$CLD/quest/help/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/help/6"
	}
	( exec $SOURCE "$URL/career" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	echo "/career/"
	ENTER=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
	ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
	BREAK=$(echo $(( `date +%M` + 2 )))
	until [[ -z $ENTER ]]; do
		[[ $(date +%M) = $BREAK ]] && break
		( exec $SOURCE "$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		echo " ⚔ $ACCESS"
		ENTER=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep -o 'career/attack')
		ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/career/attack/' | head -n1 | awk -F\' '{ print $2 }')
		sleep 1s
	done
	[[ -n $CLD ]] && {
		( exec $PAGE "$URL/clan/$CLD/quest/deleteHelp/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/deleteHelp/6"
		( exec $PAGE "$URL/clan/$CLD/quest/end/6" -o user_agent="$(shuf -n1 .ua)" | tail -n0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/end/6"
	}
	unset CLD ENTER ACCESS
	echo -e "career (✔)\n"
}
