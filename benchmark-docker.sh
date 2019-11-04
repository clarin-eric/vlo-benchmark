#!/bin/sh

VOLUME_DATA="${VOLUME_DATA:-vlo-benchmark-data}"
VOLUME_SOLR_DATA="${VOLUME_SOLR_DATA:-vlo-benchmark-solr-data}"

DATA_URL="${DATA_URL:-https://gitlab.com/CLARIN-ERIC/docker-vlo-sample-data/raw/master/image/sample-data.tar.gz}"
#DATA_URL="https://surfdrive.surf.nl/files/index.php/s/9FugiBAyNjlCF66/download"


set -e

echo "Building benchmark image..."

docker build -t vlo-benchmark:latest ./docker

docker run --rm  --name vlo-benchmark \
	-v "$(pwd):/benchmark" \
	-v "${VOLUME_DATA}:/data" \
	-e DATA_DIR=/data \
	-v "${VOLUME_SOLR_DATA}:/solr-data" \
	-e SOLR_DATA_DIR=/solr-data \
	-e "DATA_URL=${DATA_URL}" \
	--entrypoint="/bin/bash" \
	vlo-benchmark:latest /benchmark/benchmark.sh $@

echo "Removing volumes..."
docker volume rm "${VOLUME_DATA}"
docker volume rm "${VOLUME_SOLR_DATA}"
