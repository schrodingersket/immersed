#!/usr/bin/env bash
set -e

source ./env.sh

VERSION_MODIFIER=
NVIDIA_GPU=

[[ "true" -eq "$USE_INTEL_MEDIA_SDK" ]] && VERSION_MODIFIER="-intel-media-sdk"
#[[ "true" -eq "$USE_NVIDIA_GPU" ]] && NVIDIA_GPU="--gpus $IMMERSED_NVIDIA_GPUS"

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
	   -v xorg.conf:/etc/X11/xorg.conf \
           -v immersed:/root \
           -e DISPLAY=unix$DISPLAY \
	   $NVIDIA_GPU \
	   schrodingersket/immersed:$IMMERSED_VERSION$VERSION_MODIFIER "$@"
