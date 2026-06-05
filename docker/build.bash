#!/bin/bash
# Build the docker image.
# Not using set -e as `docker inspect` can legitimately fail.
# set -x

docker_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
. ${docker_dir}/vars.bash

docker inspect --type=image ${DOCKER_HUB_USER_NAME}/${IMAGE_NAME}:${IMAGE_TAG}  &> /dev/null
if [ $? == 1 ]
then
    set -e
    # Pass in user and group IDs as build arguments to avoid permission issues when sharing files between the container and the host.
    docker build \
        --build-arg UID=$(id -u) \
        --build-arg GID=$(id -g) \
        -t ${DOCKER_HUB_USER_NAME}/${IMAGE_NAME}:${IMAGE_TAG} \
        -f dockerfile \
        .
    set +e
fi

echo
echo "Build of ${IMAGE_NAME} took $SECONDS seconds."
echo
