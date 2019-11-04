#!/bin/sh
set -e
docker build -t vlo-benchmark:latest ./docker
docker run --name vlo-benchmark --rm -v $(pwd):/benchmark --entrypoint="/bin/bash" vlo-benchmark:latest /benchmark/benchmark.sh $@

