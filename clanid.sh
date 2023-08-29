# /clan id
_clanid () {
	( exec $SOURCE "$URL/clan" -o user_agent="$(shuf -n1 .ua)" >CLD ) &
	_timexit 10
	CLD=$(cat CLD | sed "s/\/clan\//\\n/g" | grep 'built\/' | awk -F\/ '{ print $1 }')
}
