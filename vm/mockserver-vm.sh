#!/usr/bin/env bash

export DOCKER_IMAGE=discoverydev/mock-server
export DOCKER_CONTAINER=mockserver
export DOCKER_CONTAINER_PUBLISH="--publish=1080:1080 --publish=1090:1090"
export DOCKER_CONTAINER_ENV="--env JAVA_OPTS=-Xmx2g"
export DOCKER_VM_MEMORY=3072

#source docker-vm_lib.sh

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
	bundle install
	ruby mock_server_setup.rb
}

#for arg in "$@"; do $arg; done

echo " ================================================== HEYOOOOOO ====================================================="
echo "If you're seeing this message, you're trying to use the old, docker-machine version of the mockserver scripts."
echo "The implementation of the mockserver docker container has changed to eliminate the dependency on docker-machine."
echo "Please see the readme in the mockserver repo for instructions on how to run, restart, and otherwise use mockserver."
echo "And, as always, if you need more help - go ask Coleman."
echo " ================================================== /HEYOOOOOO ====================================================="
