#!/usr/bin/env bash
set -e

source ./env.sh

VERSION_MODIFIER=
NVIDIA_GPU=

[[ "true" -eq "$USE_INTEL_MEDIA_SDK" ]] && VERSION_MODIFIER="-intel-media-sdk"
[[ "true" -eq "$USE_NVIDIA_GPU" ]] && NVIDIA_GPU="--gpus $IMMERSED_NVIDIA_GPUS"

# Set xhost permissions
#
xhost local:$USER

#-v immersed:/root \
# Run container
#
docker run -ti \
	   --rm \
	   -h $(hostname) \
	   --name=immersed \
	   --net=host \
	   -v immersed:/root \
	   -v /tmp/.X11-unix:/tmp/.X11-unix \
	   -e DISPLAY=unix$DISPLAY \
	   $NVIDIA_GPU \
	   schrodingersket/immersed:$IMMERSED_VERSION$VERSION_MODIFIER "$@"
