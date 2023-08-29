# /campaign
_campaign () {
	echo "campaign ..."
	( exec $SOURCE "$URL/campaign" -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
	_timexit 10
	ENTER=$(cat $TMP/SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
	ACCESS=$(cat $TMP/SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
	BREAK=$(echo $(( `date +%M` + 2 )))
	while [[ -n $ENTER && -n $ACCESS ]]; do
		[[ $(date +%M) = $BREAK ]] && break
		( exec $SOURCE $URL$ACCESS -o user_agent="$(shuf -n1 .ua)" >$TMP/SRC ) &
		_timexit 10
		ENTER=$(cat $TMP/SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }' | awk -F\/ '{ print $3 }')
		ACCESS=$(cat $TMP/SRC | sed "s/href='/\n/g" | grep "/campaign/" | head -n1 | awk -F\' '{ print $1 }')
		echo "$ACCESS"
		sleep 1s
	done
	unset ENTER ACCESS
	echo -e "campaign (✔)\n"
}
