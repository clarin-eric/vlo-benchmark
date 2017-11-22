#!/bin/sh
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
DATA_URL="https://gitlab.com/CLARIN-ERIC/docker-vlo-sample-data/raw/master/image/sample-data.tar.gz"
DATA_DIR="/var/vlo-benchmark-data/"
DEFAULT_ITERATIONS=1

if [ ! -z "$1" ] && [ $1 -gt 0 ]; then
	N="$1"
else
	N="$DEFAULT_ITERATIONS"
fi

echo "Running ${N} iterations"

for i in `seq 1 $N`; do
	echo "Iteration ${i}:"
	echo "Emptying data directory..."
	(cd "$DATA_DIR" && rm -rf *)
	echo "Fetching data..."
	(cd "$DATA_DIR" && curl -s -L "$DATA_URL" | tar zxf -)
	(cd "$DIR" && ./time-import.sh)
done
