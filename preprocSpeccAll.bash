#!/usr/bin/env bash

#
# run preprocessing for everyone (1* in SPECC_Raw)
#  in paralle
#

## job control
MAXJOBS=5
sleeptime=050
function waitforjobs {
	while [ $(jobs -p | wc -l) -ge $MAXJOBS ]; do
		echo "@$MAXJOBS jobs, sleeping $sleeptime s"
		jobs | sed 's/^/\t/'
		sleep $sleeptime
	done
}

scriptdir=$(cd $(dirname $0);pwd)

## actual loop
for subjSpeccdir  in $scriptdir/../SPECC/MR_Raw/*; do
	subjdate=$(basename $subjSpeccdir)
 $scriptdir/preprocSpeccSubj.bash $subjdate &
	waitforjobs
done

# wait for everything to finish before saying we're done
wait

