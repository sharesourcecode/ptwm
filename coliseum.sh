_Cstart () {
# /enterFight
	HPER=38 # % - to heal
	RPER=18 # % + opponent hp to be changed
	echo -e "\nColiseum ..."
	( exec $PAGE $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	grep -q '/graphics/0' $TMP/SRC && {
		( exec $PAGE $URL/settings/graphics/0 -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		echo -e "/settings/graphics/0"
	}
	grep -q '?close_clan_msg' $TMP/SRC && {
		( exec $SOURCE "$URL/coliseum/?close_clan_msg=true" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		echo '/coliseum/?close_clan_msg=true'
	}
	( exec $SOURCE "$URL/coliseum" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	_show () {
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
	grep -o '?end_fight' $TMP/SRC && {
		( $PAGE "$URL/coliseum/?end_fight=true" -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n7 | sed "/\[2hit/d;/\[str/d;/combat/d" ) &
		_timexit 10
		echo "/coliseum/?end_fight=true"
	}
	( exec $SOURCE "$URL/coliseum" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
#	ACCESS=$(cat $TMP/SRC | sed 's/href=/\n/g' | grep '/enterFight/' | head -n1 | awk -F\' '{ print $2 }')
	ACCESS=$(sed -n 1p <<<$(grep -o -P '(/coliseum(/\w+/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
	echo -e " 👣 Entering...\n$ACCESS"
	( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	echo "$ACCESS"
# /wait
	echo " 😴 Waiting..."
	until $(grep -q 'coliseum/dodge/' $TMP/SRC) ; do
		echo -e " 💤	...\n$ACCESS"
		( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		sleep 1
		ACCESS=$(sed -n 1p <<<$(grep -o -P '(/coliseum(/\w+/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
	done
	FULL=$(cat $TMP/SRC | grep -o -P "(hp)\W{1,4}\d{1,6}" | sed "s,hp[']\/[>],,;s,\ ,,")
	_access
	HP3=$HP1
	until [[ !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q 'bg=coliseum' $TMP/SRC) || !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q '/coliseum/enterFight/' $TMP/SRC) || !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q '/images/coliseum/stars/0.png' $TMP/SRC) || !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q '/images/coliseum/stars/1.png' $TMP/SRC) || !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q '/coliseum/?end_fight=true' $TMP/SRC) ]];
	do
# /dodge
		grep -q '/coliseum/dodge/' $TMP/SRC || {
			( exec $SOURCE "$URL/coliseum" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			_access
			echo -e "\e[00;33m\e[01;07mBattle's over.\e[00m\n" ; sleep 3s
			break
		}
		if [[ -z $DT && $HP3 -ne $HP1 ]] ; then
			( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
			HP3=$HP1
# /heal
		elif [[ -z $HT && $HP1 -le $HLHP ]] ; then
			( exec $SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n\033[31m\033[01mHP < $HPER%\n🆘 \e[03;31m\e[02;04m$HEAL\e[00m"
			echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
			HP3=$HP1
			[[ -z $DT ]] && {
				( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
				echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
				HP3=$HP1
			}
# /grass
#		elif [[ $grss -ge 12 && $ddg != [34] && $hl != 1[78] && `expr $HP1 + $HP1 \* 90 \/ 100` -le $HP2 ]] ; then
#			HPER='30'
#			RPER='13'
#			echo '🙌'
#			SRC=$($SOURCE "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			sleep $ITVL
# /stone
#		[[ `expr $HP1 + $HP1 \* 1 \/ 100` -le $HP2 ]]
#			echo '💪'
#			SRC=$($SOURCE "$URL$stone" -o user_agent="$(shuf -n1 .ua)")
#			_access
#			sleep $ITVL
# /random
		elif [[ -n $(grep -o "$USER" $TMP/allies.txt) || $(echo $(($HP1 + $HP1 * $RPER / 100))) -le $HP2 ]] ; then
# random in these seconds 00|06|12|18|24|30|36|42|48|54
			until $(case $(date +%S) in (00|06|12|18|24|30|36|42|48|54) exit 1 ;; esac) ;
			do
				( exec $SOURCE "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n\033[35m$USER\n🔁 \e[03;35m\e[02;04m$ATKRND\e[00m"
				echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
				HP3=$HP1
				[[ -z $DT ]] && {
					( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
					echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
					_access
					HP3=$HP1
				}
				[[ -z $HT && $HP1 -le $HLHP ]] && {
					( exec $SOURCE "$URL$HEAL" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					echo -e "$URL\n\033[31m\033[01mHP < $HPER%\n🆘 \e[03;31m\e[02;04m$HEAL\e[00m"
					echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
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
				echo -e "\033[33m$DT\t\033[31m\033[01m$HT\t\033[34m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
			done
		fi
	done
	unset HPER RPER ITVL ACCESS EXIT HP3 INT
# /view
	echo ""
	( $PAGE $URL/coliseum/ -o user_agent="$(shuf -n1 .ua)" | head -n11 | tail -n6 | sed "/\[2hit/d;/\[str/d;/combat/d" | grep --color "$ACC" ) &
	_timexit 10
	_unset
	[[ $PLAY != "cl" ]] && echo "You can run bash twm/play.sh -cl"
	echo 'Coliseum (✔)'
	sleep 5s
}
_coliseum () {
	if $(case $(date +%H:%M) in (09:2[5-9]|9:5[5-9]|10:1[0-4]|10:2[5-9]|10:5[5-9]|12:2[5-9]|13:5[5-9]|14:5[5-9]|15:5[5-9]|16:1[0-4]|16:2[5-9]|18:5[5-9]|20:5[5-9]|21:2[5-9]|21:5[5-9]|22:2[5-9]) exit 1 ;; esac) ; then _Cstart ; else echo "Battle or event time..." ; fi
#	_Cstart
}
