#!/bin/bash
DOCKER_RUN_ARGS="--volume ${PWD}/exp:/home/${USER}/exp \
                 --volume $XAUTHORITY:/home/${USER}/.Xauthority"

.scripts/run.sh build.sh config "${DOCKER_RUN_ARGS}"
