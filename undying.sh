_Ustart () {
	echo "undying"
	_access
	HPER=55
	RPER=5
	_show () {
		YOU=$(sed -n 's,\ [<]s,,;s,\ ,_,;1p' <<<$(grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" $TMP/SRC))
		USER=$(sed -n 's,\ [<]s,,;s,\ ,_,;2p' <<<$(grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" $TMP/SRC))
		HP1=$(sed "s,hp[']\/[>],,;s,\ ,," <<<$(grep -o -P "(hp)\W{1,4}\d{1,6}" $TMP/SRC))
		HP2=$(sed -n 's,nbsp[;],,;s,\ ,,;1p' <<<$(grep -o -P "(nbsp)\W{1,2}\d{1,6}" $TMP/SRC))
		if [[ -n $OUTGATE ]] ; then
			echo " $(grep -oP '\w+: \d{1}s' $TMP/SRC)"
		fi
	}
# /battle
	while [[ -n $OUTGATE ]] ; do
		[[ $(date +%M) = 06 ]] && break
# hit in these seconds 00|06|12|18|24|30|36|42|48|54
		until $(case $(date +%S) in (00|06|12|18|24|30|36|42|48|54) exit 1 ;; esac) ;
		do
			( exec $SOURCE "$URL$HIT" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo "$URL"
			_access
			echo -e " 🎲 \e[03;34m\e[02;04m$HIT\e[00m"
#			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
#			sleep 1.44
			HIT=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
			OUTGATE=$(cat $TMP/SRC | grep -o 'out_gate')
		done
	done
	_AdeleteEnd
	unset ACCESS MANA HIT OUTGATE
# /view
	echo ""
	( exec $PAGE $URL/undying -o user_agent="$(shuf -n1 .ua)" | head -n15 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC ) &
	_timexit 10
	echo -e "undying (✔)"
# /clear bag
	( exec $PAGE $URL/inv/bag/sellAll/1/ -o user_agent="$(shuf -n1 .ua)" | tail -n 0 ) &
	_timexit 10
	echo -e "/inv/bag/sellAll/1/"
}
_undying () {
	case $(date +%H:%M) in
		(9:5[5-9]|15:5[5-9]|21:5[5-9])
			( exec $SOURCE "$URL/undying/enterGame/" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			_arena
			echo 'Valley of the Immortals will be started...'
			while $(case $(date +%M) in (59) exit 1 ;; esac) ;
			do
				sleep 3
			done
# /enterGame
			echo " 👣 Entering..."
			( exec $SOURCE "$URL/undying/enterGame/" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "/undying/"
			ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
			MANA=$(cat $TMP/SRC | grep -o 'undying/mana/' | head -n1)
# /wait
			echo " 😴 Waiting..."
			until [[ -n $MANA ]] ; do
				[[ $(date +%M) = 00 && $(date +%S) > 19 ]] && break
				( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e " 💤 $ACCESS"
				ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/undying/' | head -n1 | awk -F\' '{ print $2 }')
				MANA=$(cat $TMP/SRC | grep -o 'undying/mana/' | head -n1)
			done
			( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$ACCESS"
			MANA=$(cat $TMP/SRC | grep -o 'undying/mana/' | head -n1)
			HIT=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
			_AtakeHelp
			_fullmana
			( exec $SOURCE "$URL/undying" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "/undying/"
			MANA=$(cat $TMP/SRC | grep -o 'undying/mana/' | head -n1)
			HIT=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep 'undying/hit/' | head -n1 | awk -F\' '{ print $2 }')
			OUTGATE=$(cat $TMP/SRC | grep -o 'out_gate')
			_Ustart ;;
	esac
}
