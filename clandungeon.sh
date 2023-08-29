# /clandungeon
function _clandungeon () {
	_clanid
	if [[ -n $CLD ]]; then
		echo "Checking Clan Dungeon..."
		( exec $SOURCE "$URL/clandungeon/?close" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | awk -F\' '{ print $2 }')
		EXIST=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
		BREAK=$(echo $(( `date +%M` + 2 )))
		until [[ -z $EXIST ]]; do
			[[ $(date +%M) = $BREAK ]] && break
			( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/clandungeon/attack/' | head -n1 | awk -F\' '{ print $2 }')
			EXIST=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep -o 'clandungeon/attack')
			echo " ⚔ $ACCESS"
			sleep 1s
		done
		echo -e "Clan Dungeon (✔)\n"
	fi
	unset CLD ACCESS EXIST
}
