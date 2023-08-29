# /cave
_cave () {
	echo "cave ..."
	_clanid
	if [[ -n $CLD ]]; then
#		( exec $PAGE "$URL/clan/$CLD/quest/take/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
#		_timexit 10
#		echo "/clan/$CLD/quest/take/5"
		( exec $PAGE "$URL/clan/$CLD/quest/help/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/help/5"
	fi
	_condition () {
		( exec $SOURCE "$URL/cave/" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		ACCESS1=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n1 | awk -F\' '{ print $2 }')
		DOWN=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/down' | awk -F\' '{ print $2 }')
		ACCESS2=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }')
		ACTION=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | awk -F\' '{ print $2 }' | tr -cd "[[:alpha:]]")
		MEGA=$(cat $TMP/SRC | sed 's/src=/\n/g' | grep '/images/icon/silver.png' | grep "'s'" | tail -n1 | grep -o 'M')
	}
	_condition
	num=1
	BREAK=$(echo $(( `date +%M` + 2 )))
	until [[ $num -eq 0 && "$PLAY" != "cv" ]]; do
		[[ "$PLAY" != "cv" && $(date +%M) = $BREAK ]] && break
		_condition
		case $ACTION in
			(cavechancercavegatherrcavedownr)
				( exec $SOURCE "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo "$ACCESS2"
				num=$[$num-1] ;;
			(cavespeedUpr)
				( exec $SOURCE "$URL$ACCESS2" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo "$ACCESS2"
				num=$[$num-1] ;;
			(cavedownr|cavedownrclanbuiltprivateUpgradetruerrefcave)
				num=$[$num-1] ;
				( exec $SOURCE "$URL$DOWN" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo "$DOWN" ;;
			(caveattackrcaverunawayr)
				num=$[$num-1] ;
				( exec $SOURCE "$URL$ACCESS1" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo "$ACCESS1"
				( exec $SOURCE "$URL/cave/runaway" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo "/cave/runaway" ;;
			(*) num=0 ;;
		esac
		cat $TMP/SRC | sed 's/href=/\n/g' | grep '/cave/' | head -n2 | tail -n1 | awk -F\' '{ print $2 }'
		sleep 1s
	done
	if [[ -n $CLD ]]; then
		( exec $PAGE "$URL/clan/$CLD/quest/deleteHelp/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/deleteHelp/5"
		( exec $PAGE "$URL/clan/$CLD/quest/end/5" -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
		_timexit 10
		echo "/clan/$CLD/quest/end/5"
	fi
	unset CLD ACCESS1 DOWN ACCESS2 ACTION MEGA num
	[[ $PLAY != "cv" ]] && echo "You can run bash twm/play.sh -cv"
	echo -e "cave (✔)\n"
}
