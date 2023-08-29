_loginlogoff () {
	[[ -f "$TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc=" ]] && {
		( w3m -cookie -post $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc= "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)" | head -n 0 ) &
		_timexit 10
		( w3m -cookie -post $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc= "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)" | head -n 0 ) &
		_timexit 10
	}
	( w3m -cookie "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[level" | grep -o -P "\s\p{Lu}{1}\p{Ll}{0,15}\s{0,1}\p{Lu}{0,1}\p{Ll}{0,13}\s" >$TMP/ACC ) &
	_timexit 10
	sed -i 's/^[ \t]*//;s/[ \t]*$//' ACC
	ACC=$(cat $TMP/ACC)
	[[ -n $ACC && -n $URL ]] && {
		check=5
		until [[ $check -lt 1 ]]; do
			clear
			echo "Please wait..."
			echo -e "[Wait to $ACC... ("$check"s) - ENTER to other account] \n"
			check=$[$check-1]; read -t1 && \
			ACC="" && break
		done
	}
	clear
	echo "Please wait..."
	BREAK=$(echo $(( `date +%M` + 5 )))
	while [[ -z $ACC && -n $URL ]]; do
		[[ $(date +%M) = $BREAK ]] && break
		_login () {
# /logoff
			uname | grep -q -i cygwin || {
				( w3m -cookie "$URL/?exit" -o user_agent="$(shuf -n1 .ua)" | head -n 0 ) &
				_timexit 20
			}
			unset username; unset password
			echo -e "\e[00;33m\e[01;07mIn case of error will repeat\e[00m\n"
			echo -ne "Username: "
			read username
			prompt="Password: "
			charcount=0
			while IFS= read -p "$prompt" -r -s -n 1 char; do
# /Enter - accept password
				if [[ $char == $'\0' ]]; then
					break
				fi
# /Backspace
				if [[  $char  == $'\177' ]]; then
					if [[ $charcount -gt 0 ]]; then
						charcount=$((charcount - 1))
						prompt=$'\b \b'
						password="${password%?}"
					else
						prompt=''
					fi
				else
					charcount=$((charcount + 1))
					prompt='*'
					password+="$char"
				fi
			done
			echo -e "\n	Please wait..."
# /cryptography
			[[ -z $ACC ]] && {
				echo "login=$username&pass=$password" | openssl enc -aes-256-cbc -md sha512 -a -pbkdf2 -iter 100000 -salt -pass pass:"　 　$username" > $TMP/.cript.txt
				chmod 600 $TMP/.cript.txt
# /decryption
				cat $TMP/.cript.txt | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"　 　$username" >$TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc=
				chmod 600 $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc=
			} || {
				cat $TMP/.cript.txt | openssl enc -aes-256-cbc -md sha512 -a -d -pbkdf2 -iter 100000 -salt -pass pass:"　 　$ACC" >$TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc=
				chmod 600 $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc=
			}
# /login2x
			sed -i "/$username/d" ~/.tmp/runners/login.txt &> /dev/null
			sed -i "/$username/d" ~/.tmp/runners/usernames.txt &> /dev/null
			unset username password
			( w3m -cookie -post $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc= "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)" | head -n 0 ) &
			_timexit 10
			( w3m -cookie -post $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc= "$URL/?sign_in=1" -o user_agent="$(shuf -n1 .ua)" | head -n 0 ) &
			_timexit 10
			rm $TMP/U2FsdGVkX19fbuHc3eVPLoBfEyrkx6GUywLIYsLi8hc= &> /dev/null
			rm $TMP/login.txt &> /dev/null
		}
		_login
		clear
		echo "Please wait..."
		( w3m -cookie "$URL/user" -o user_agent="$(shuf -n1 .ua)" | grep "\[level" | cut -d" " -f2 >$TMP/ACC ) &
		_timexit 10
		ACC=$(cat $TMP/ACC)
		[[ -n $ACC ]] && break
	done
	_msgs
}
