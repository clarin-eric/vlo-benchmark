#!/bin/bash

# On Prepare MacOS: 
#	brew install gnu-time

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OUTFILE=${DIR}/log/benchmark.out
if [ ! -e $OUTFILE ]; then
       echo "timestamp;real;user;sys" >> $OUTFILE
fi

if [ -x /usr/local/bin/gtime ];	then 
	TIME_CMD=/usr/local/bin/gtime
elif [ -x /usr/bin/time ]; then 
	TIME_CMD=/usr/bin/time
else
	echo "Time command not found (install 'time' or (for MacOS) 'gnu-time')" > /dev/stderr
	exit 1
fi

if [ -x /usr/local/bin/gdate ]; then
	DATE=`/usr/local/bin/gdate --rfc-3339=seconds`
elif which date > /dev/null 2>&1; then
	DATE=`$(which date) --rfc-3339=seconds`
else
	echo "Could not set date. If on MacOS, install 'gnu-time'" > /dev/stderr
fi

echo -n $DATE >> $OUTFILE \
	&& ${TIME_CMD} -a -o $OUTFILE -f ";%e;%U;%S" ${DIR}/vlo/bin/vlo_solr_importer.sh $@
