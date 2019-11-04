#!/bin/sh
set -e
docker build -t vlo-benchmark:latest ./docker
docker run --name vlo-benchmark --rm -v $(PWD):/benchmark vlo-benchmark:latest
