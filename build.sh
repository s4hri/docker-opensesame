#!/bin/bash
# Arguments:
#   $1: config file

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
source config

if [ $NVIDIA_CARD = "yes" ]; then
  NVIDIA_OPTS='--gpus all'
  SRC_IMAGE="nvidia/opengl:1.0-glvnd-runtime-ubuntu18.04"
  DOCKER_IMAGE_NAME="${DOCKER_IMAGE_NAME}-nvidia"
else
  SRC_IMAGE="ubuntu:18.04"
  NVIDIA_OPTS=''
fi

.scripts/build.sh ${DOCKER_IMAGE_NAME} \
                  ${CURRENT_DIR}/runtime/ \
                  "--build-arg SRC_IMAGE=${SRC_IMAGE} \
                   --build-arg USER=$USER \
                   --build-arg LOCAL_USER_ID=$(id -u $USER)"