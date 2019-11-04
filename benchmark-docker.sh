#!/bin/sh

VOLUME_DATA="${VOLUME_DATA:-vlo-benchmark-data}"
VOLUME_SOLR_DATA="${VOLUME_SOLR_DATA:-vlo-benchmark-solr-data}"

set -e

echo "Building benchmark image..."

docker build -t vlo-benchmark:latest ./docker

echo "Creating volumes..."
docker volume create "${VOLUME_DATA}"
docker volume create "${VOLUME_SOLR_DATA}"

docker run --rm  --name vlo-benchmark \
	-v $(pwd):/benchmark \
	-v ${VOLUME_DATA}:/data \
	-e DATA_DIR=/data \
	-v ${VOLUME_SOLR_DATA}:/solr-data \
	-e SOLR_DATA_DIR=/solr-data \
	--entrypoint="/bin/bash" \
	vlo-benchmark:latest /benchmark/benchmark.sh $@

echo "Removing volumes..."
docker volume rm "${VOLUME_DATA}"
docker volume rm "${VOLUME_SOLR_DATA}"
