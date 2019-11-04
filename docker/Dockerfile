FROM registry.gitlab.com/clarin-eric/docker-alpine-supervisor-java-base:openjdk8-1.2.4
RUN apk add --update coreutils
WORKDIR /benchmark
ENTRYPOINT /benchmark/benchmark.sh

