#!/usr/bin/env bash
RUN=$1
while true ; do
	pidf=$(ps ax -o pid=,args= | grep 'twm/twm' | grep -v 'grep' | head -n1 | grep -o -P '(\d{3,5})')
	until [[ -z $pidf ]] ; do
		kill -9 $pidf 2> /dev/null
		pidf=$(ps ax -o pid=,args= | grep 'twm/twm' | grep -v 'grep' | head -n1 | grep -o -P '(\d{3,5})')
		sleep 1s
	done
	_RUN () {
		if [[ "$RUN" == "-boot" ]] ; then
			echo 'boot' > ~/twm/RUN
			~/twm/twm.run -boot
		elif [[ "$RUN" == "-cl" ]] ; then
			echo 'cl' > ~/twm/RUN
			~/twm/twm.run -cl
		elif [[ "$RUN" == "-cv" ]] ; then
			echo 'cv' > ~/twm/RUN
			~/twm/twm.run -cv
		else
			unset RUN
			echo 'false' > ~/twm/RUN
			~/twm/twm.run
		fi
	}
	_RUN
	sleep 1s
done
