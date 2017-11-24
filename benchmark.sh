#!/bin/sh
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
#DATA_URL="https://gitlab.com/CLARIN-ERIC/docker-vlo-sample-data/raw/master/image/sample-data.tar.gz"
#DATA_URL="https://surfdrive.surf.nl/files/index.php/s/L4DiCkv1n7FA0w0/download"
DATA_URL="https://surfdrive.surf.nl/files/index.php/s/9FugiBAyNjlCF66/download"
DATA_DIR="/tmp/vlo-benchmark-data/"
SOLR_DATA_DIR="/tmp/vlo-benchmark-solrdata"
DEFAULT_ITERATIONS=1

if ! [ -d "$DATA_DIR" ]; then
	echo "Creating data directory $DATA_DIR"
	mkdir -p "$DATA_DIR"
fi

if ! [ -d "$SOLR_DATA_DIR" ]; then
	echo "Creating Solr data directory $SOLR_DATA_DIR"
	mkdir -p "$SOLR_DATA_DIR"
fi

if [ ! -z "$1" ] && [ $1 -gt 0 ]; then
	N="$1"
else
	N="$DEFAULT_ITERATIONS"
fi

if curl -L http://localhost:8989 > /dev/null 2>&1; then
	echo "Found Tomcat running at localhost:8989"
else
	echo "Starting Solr server"
	(cd "$DIR" && ./start-solr.sh)
fi

echo "Emptying data directory..."
(cd "$DATA_DIR" && rm -rf *)
echo "Fetching data..."
(cd "$DATA_DIR" && curl -s -L "$DATA_URL" | tar zxf -)

echo "Running ${N} iterations"

for i in `seq 1 $N`; do
	echo "Iteration ${i}:"
	(cd "$DIR" && ./time-import.sh)
done
