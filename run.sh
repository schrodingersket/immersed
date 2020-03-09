#!/usr/bin/env bash
set -e

source ./env.sh

# Set xhost permissions
#
xhost local:$USER

# Run container
#
docker run -ti \
	   --rm \
	   -h $(hostname) \
	   --name=immersed \
	   --net=host \
	   -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -v immersed:/root \
	   -e DISPLAY=unix$DISPLAY \
	   schrodingersket/immersed:$IMMERSED_VERSION "$@"
