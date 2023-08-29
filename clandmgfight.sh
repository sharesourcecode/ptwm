_CDFstart () {
# /enterFight
	HPER=38 # % - to heal
	RPER=14 # % + opponent hp to be changed
	_show () {
		CLAN=$(sed -n 's,\ [(],,;s,\ ,_,;2p' <<<$(grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\(" $TMP/SRC))
		YOU=$(sed -n 's,\ [<]s,,;s,\ ,_,;1p' <<<$(grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" $TMP/SRC))
		USER=$(sed -n 's,\ [<]s,,;s,\ ,_,;2p' <<<$(grep -o -P "\p{Lu}{1}\p{Ll}{0,15}[\ ]{0,1}\p{L}{0,14}\s\Ws" $TMP/SRC))
		HP1=$(sed "s,hp[']\/[>],,;s,\ ,," <<<$(grep -o -P "(hp)\W{1,4}\d{1,6}" $TMP/SRC))
		HP2=$(sed -n 's,nbsp[;],,;s,\ ,,;1p' <<<$(grep -o -P "(nbsp)\W{1,2}\d{1,6}" $TMP/SRC))
		if [[ -n $OUTGATE ]] ; then
			[[ $HP1 -gt 0 && $HP2 -gt 0 ]] && echo -e "$YOU: $HP1 - $HP2 :$USER\n"
			[[ $HP1 -eq 0 ]] && echo -e "$YOU: 💀 - $HP2 :$USER\n"
			[[ $HP2 -eq 0 ]] && echo -e "$YOU: $HP1 - 💀 :$USER\n"
		fi
	}
#	FULL=$(sed "s,hp[']\/[>],,;s,\ ,," <<<$(grep -o -P "(hp)\W{1,4}\d{1,6}" $TMP/SRC))
	FULL=$(cat $TMP/FULL)
	_access
	HP3=$HP1
	until [[ -n $BEXIT && -z $OUTGATE ]] ; do
		[[ $(date +%M) = 08 ]] && break
# /dodge
		if [[ -z $DT && $HP3 -ne $HP1 ]] ; then
			( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
			HP3=$HP1
# /heal
		elif [[ -z $HT && $HP1 -le $HLHP ]] ; then
			( exec $SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n\033[31m\033[01mHP < $HPER%\n🆘 \e[03;31m\e[02;04m$HEAL\e[00m"
			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
			HP3=$HP1
			[[ -z $DT ]] && {
				( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
				echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
				HP3=$HP1
			}
# /grass
		elif [[ -z $GT && -n $HT && -n $DT && $HP3 -ne $HP1 ]] ; then
			( exec $SOURCE "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n🙌 \e[03;32m\e[02;04m$GRASS\e[00m"
			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
# /stone
		elif [[ -z $ST && -n $HT && -n $DT && $HP1 -le $HLHP ]] ; then
			( exec $SOURCE "$URL$stone" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n💪 \e[03;30m\e[02;04m$stone\e[00m"
			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
# /random
		elif [[ -n $(grep -o "$CLAN" $TMP/callies.txt) || -n $(grep -o "$USER" $TMP/allies.txt) || $(echo $(($HP1 + $HP1 * $RPER / 100))) -le $HP2 ]] ; then
# random in these seconds 00|06|12|18|24|30|36|42|48|54
			until $(case $(date +%S) in (00|06|12|18|24|30|36|42|48|54) exit 1 ;; esac) ;
			do
				( exec $SOURCE "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n\033[35m$USER\n🔁 \e[03;35m\e[02;04m$ATKRND\e[00m"
				echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
				HP3=$HP1
				[[ -z $DT ]] && {
					( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
					echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
					_access
					HP3=$HP1
				}
				[[ -z $HT && $HP1 -le $HLHP ]] && {
					( exec $SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					echo -e "$URL\n\033[31m\033[01mHP < $HPER%\n🆘 \e[03;31m\e[02;04m$HEAL\e[00m"
					echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
					_access
					HP3=$HP1
				}
			done
# /atk
		else
# attack in these seconds 00|06|12|18|24|30|36|42|48|54
			until $(case $(date +%S) in (00|06|12|18|24|30|36|42|48|54) exit 1 ;; esac) ;
			do
				( exec $SOURCE "$URL$ATK" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n🎯 \e[03;34m\e[02;04m$ATK\e[00m"
				echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
			done
		fi
	done
	unset HPER RPER ITVL ACCESS EXIT HP3 INT
# /view
	echo ""
	( exec $PAGE $URL/clandmgfight -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC ) &
	_timexit 10
	_unset
	echo "clandmgfight(✔)"
	sleep 30
}
_clandmgfight () {
	case $(date +%H:%M) in
		(09:2[8-9]|21:2[8-9])
			( exec $SOURCE "$URL/train" -o user_agent="$(shuf -n1 .ua)" | grep -oP '(?<=\()[0-9]+(?=\))' >$TMP/FULL ) &
			_timexit 10
			( exec $SOURCE "$URL/clandmgfight/?close=reward" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			( exec $SOURCE "$URL/clandmgfight/enterFight" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "\nClan fight"
			echo 'Clan tournament will be started...'
			while $(case $(date +%M:%S) in (29:[3-5][0-9]) exit 1 ;; esac) ;
			do
				sleep 3
			done
			( exec $SOURCE "$URL/clandmgfight/enterFight" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo $URL
			ACCESS=$(sed -n 1p <<<$(grep -o -P '(/clandmgfight(/\w+/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
			echo -e " 👣 Entering...\n$ACCESS"
# /wait
			echo " 😴 Waiting..."
			until [[ $(echo $ACCESS | grep -o 'clandmgfight/dodge/') ]] ; do
				[[ $(date +%M) = 30 && $(date +%S) > 19 ]] && break
				echo -e " 💤	...\n$ACCESS"
				( exec $SOURCE "$URL/clandmgfight/" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				ACCESS=$(sed -n 1p <<<$(grep -o -P '(/clandmgfight(/\w+/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
				sleep 3
			done
			_CDFstart ;;
	esac
}
