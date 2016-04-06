#!/usr/bin/env bash 

export DOCKER_IMAGE=discoverydev/mock-server
export DOCKER_CONTAINER=mockserver
export DOCKER_CONTAINER_PUBLISH="--publish=1080:1080 --publish=1090:1090"
export DOCKER_CONTAINER_ENV="--env JAVA_OPTS=-Xmx2g"
export DOCKER_VM_MEMORY=3072

source docker-vm_lib.sh

_setupvm() {
	nat ${DOCKER_CONTAINER}-http 1080 1080
	nat ${DOCKER_CONTAINER}-proxy 1090 1090
}

tail-log() {
	tail -n 100 -f $DOCKER_HOST_DATA_DIR/logs/discovery-mockserver.log
}

open() {
	/usr/bin/open "http://localhost:1080/"
}

setup() {
	cd /Users/Shared/data/mockserver
    git pull
	bundle install
	ruby mock_server_setup.rb
}

for arg in "$@"; do $arg; done
