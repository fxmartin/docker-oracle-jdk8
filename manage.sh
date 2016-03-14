#!/bin/bash
##############################################################################
# Script for managing docker image
# Based on manage.sh from https://github.com/fxmartin/docker-sshd-nginx
# Syncordis Copyright 2016
# Author: FX
# Date: 14-mar-2016
# Version: 1.0.0
##############################################################################

SCRIPT=manage.sh
VERSION=1.00

IMAGE="fxmartin/docker-oracle-jdk8"

ID=`docker ps | grep "$IMAGE" | head -n1 | cut -d " " -f1`
IP=`docker-machine env docker | grep "DOCKER_HOST" | cut -d "/" -f3 | cut -d ":" -f1`

BUILD_CMD="docker build -t=$IMAGE ."
RUN_CMD="docker run -d -p 55522:22 -p 55580:80 $IMAGE"
VERSION_CMD="docker run $IMAGE java -version"
SSH_CMD="ssh root@$IP -p 55522 -i ~/.ssh/id_rsa_docker"

is_running() {
	[ "$ID" ]
}

case "$1" in
        build)
                echo "Building Docker image: '$IMAGE'"
                $BUILD_CMD
                ;;
        start)
                if is_running; then
                	echo "Image '$IMAGE' is already running under Id: '$ID'"
                	exit 1;
                fi
                echo "Starting Docker image: '$IMAGE'"
                $RUN_CMD
                echo "Docker image: '$IMAGE' started"
                ;;

        stop)
                if is_running; then
					echo "Stopping Docker image: '$IMAGE' with Id: '$ID'"
	                docker stop "$ID"
					echo "Docker image: '$IMAGE' with Id: '$ID' stopped"

                else
                	echo "Image '$IMAGE' is not running"
                fi
                ;;

        status)
                if is_running; then
                	echo "Image '$IMAGE' is running under Id: '$ID'"
                else
                	echo "Image '$IMAGE' is not running"
                fi		
                ;;
        ssh)
                if is_running; then
                	echo "Attaching to running image '$IMAGE' with Id: '$ID'"
                	echo "command: $SSH_CMD"
                	$SSH_CMD
                else
                	echo "Image '$IMAGE' is not running"
                fi		
                ;;
		web)
                open -a "Google Chrome" "http://$IP:55580"
                ;;
        version)
                $VERSION_CMD
                ;;
        *)
                echo "Usage: $0 {build|start|stop|status|ssh|web|version}"
                exit 1
                ;;
esac

exit 0