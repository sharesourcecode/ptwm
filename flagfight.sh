_Fstart () {
# /enterFight
	HPER=40 # % - to heal
	RPER=18 # % + opponent hp to be changed
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
	FULL=$(cat $TMP/FULL)
	_access
	HP3=$HP1
	until [[ !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q '/images/town/hd/flagfight.jpg' $TMP/SRC) || !$(grep -q '/coliseum/dodge/' $TMP/SRC) && $(grep -q '/flagfight/?close=reward' $TMP/SRC) ]] ; do
		[[ $(date +%M) = 20 ]] && break
# /dodge
		grep -q '/flagfight/dodge/' $TMP/SRC || {
			( exec $SOURCE "$URL/flagfight" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			_access
			echo -e "\e[00;33m\e[01;07mBattle's over.\e[00m\n" ; sleep 3s
			break
		}
		if [[ -z $DT && $HP3 -ne $HP1 ]] ; then
			( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
			echo -e "\033[33m$DT\t\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
			HP3=$HP1
# /heal(pass banner)
		elif [[ $HP1 -le $HLHP ]] ; then
			( exec $SOURCE "$URL$SHIELD" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n\033[31m\033[01mHP < $HPER%\n🆘 \e[03;31m\e[02;04m$HEAL\e[00m"
			echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
			HP3=$HP1
			[[ -z $DT && $HP3 -ne $HP1 ]] && {
				( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
				echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
				HP3=$HP1
			}
# /grass
		elif [[ -z $GT && -n $DT && $HP3 -ne $HP1 ]] ; then
			( exec $SOURCE "$URL$GRASS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n🙌 \e[03;32m\e[02;04m$GRASS\e[00m"
			echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
# /stone
		elif [[ -z $ST && -n $DT && $HP1 -le $HLHP ]] ; then
			( exec $SOURCE "$URL$stone" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			echo -e "$URL\n💪 \e[03;30m\e[02;04m$stone\e[00m"
			echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
			_access
# /random
		elif [[ -n $(grep -o "$CLAN" $TMP/callies.txt) || -n $(grep -o "$USER" $TMP/allies.txt) || $(echo $(($HP1 + $HP1 * $RPER / 100))) -le $HP2 ]] ; then
# random in these seconds 00|06|12|18|24|30|36|42|48|54
			until $(case $(date +%S) in (00|06|12|18|24|30|36|42|48|54) exit 1 ;; esac) ;
			do
				( exec $SOURCE "$URL$ATKRND" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "$URL\n\033[35m$USER\n🔁 \e[03;35m\e[02;04m$ATKRND\e[00m"
				echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
				HP3=$HP1
				[[ -z $DT && $HP3 -ne $HP1 ]] && {
					( exec $SOURCE "$URL$DODGE" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					echo -e "$URL\n\033[33m🛡️ \e[03;33m\e[02;04m$DODGE\e[00m"
					echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
					_access
					HP3=$HP1
				}
				[[ -n $DT && $HP1 -le $HLHP ]] && {
					( exec $SOURCE "$URL$SHIELD" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					echo -e "$URL\n\033[31m\033[01mHP < $HPER%\n🆘 \e[03;31m\e[02;04m$HEAL\e[00m"
					echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
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
				echo -e "\033[33m$DT\t\033[30m$ST\t\033[32m$GT\t\033[36m$CT\e[00m"
				_access
			done
		fi
	done
	unset HPER RPER ACCESS HP3
# /view
	echo ""
	( exec $PAGE $URL/flagfight -o user_agent="$(shuf -n1 .ua)" | head -n15 | tail -n14 | sed "/\[user\]/d;/\[arrow\]/d;/\ \[/d" | grep --color $ACC ) &
	_timexit 10
	_unset
	echo "Flag Fight (✔)"
	_AtakeHelp
	_fullmana
	_AdeleteEnd
}
_flagfight () {
	case $(date +%H:%M) in
		(10:1[1-4]|16:1[1-4])
			( exec $SOURCE "$URL/train" -o user_agent="$(shuf -n1 .ua)" | grep -oP '(?<=\()[0-9]+(?=\))' >$TMP/FULL ) &
			_timexit 10
			( exec $SOURCE "$URL/flagfight/?close=reward" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
			_timexit 10
			grep -q '/images/town/hd/flagfight.jpg' $TMP/SRC && {
				( exec $SOURCE "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo 'Battle of banners will be started...'
				while $(case $(date +%M:%S) in (14:[1-4][0-9]) exit 1 ;; esac) ;
				do
					sleep 3
				done
				( exec $SOURCE "$URL/flagfight/enterFight" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
				_timexit 10
				echo -e "\nFlag Fight"
				echo $URL
				ACCESS=$(sed -n 1p <<<$(grep -o -P '(/flagfight(/\w+/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
				echo -e " 👣 Entering...\n$ACCESS"
# /wait
				echo " 😴 Waiting..."
				until $(grep -q 'flagfight/dodge' $TMP/SRC) ; do
					[[ $(date +%M) = 15 && $(date +%S) > 31 ]] && break
					echo -e " 💤	...\n$ACCESS"
					( exec $SOURCE "$URL$ACCESS" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
					_timexit 10
					ACCESS=$(sed -n 1p <<<$(grep -o -P '(/flagfight(/\w+/\Wr\W\d+|/))' $TMP/SRC) 2> /dev/null)
					sleep 3
				done
				_Fstart
			} ;;
	esac
}
