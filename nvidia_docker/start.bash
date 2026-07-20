#!/bin/bash
# Start the docker container.
# set -x

docker_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
. ${docker_dir}/vars.bash

mkdir -p ${WORKSPACE_DIR}

# Authorize the local container to access the display server.
xhost +local:docker

docker container inspect ${CONTAINER_NAME} &> /dev/null
if [ $? == 0 ]
then
    # Container exists.
    if [ "$( docker container inspect -f '{{.State.Status}}' ${CONTAINER_NAME} )" == "running" ]
    then
        # Container is running.
        echo "Container '${CONTAINER_NAME}' is already running."
    else
        # Container exists but is not running.
        docker container start ${CONTAINER_NAME} &> /dev/null
        echo "Container '${CONTAINER_NAME}' started."
    fi
else
    # Container does not exist.
    mkdir -p ${WORKSPACE_DIR}
    XDG_RUNTIME_DIR=/tmp/runtime-build
    # Setup X window for the container to use.
    XAUTH=/tmp/.docker.xauth
    if [ ! -f $XAUTH ]
    then
        xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
        if [ ! -z "$xauth_list" ]
        then
            echo $xauth_list | xauth -f $XAUTH nmerge -
        else
            touch $XAUTH
        fi
        chmod a+r $XAUTH
    fi

    docker container run \
        --detach \
        --tty \
        --net=host \
        --ipc=host \
        --name ${CONTAINER_NAME} \
        --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
        --gpus all \
        -e DISPLAY=$DISPLAY \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/wayland-0 \
        -e WAYLAND_DISPLAY=wayland-0 \
        -e XDG_RUNTIME_DIR=/tmp \
        -e __NV_PRIME_RENDER_OFFLOAD=1 \
        -e __GLX_VENDOR_LIBRARY_NAME=nvidia \
        ${DOCKER_HUB_USER_NAME}/${IMAGE_NAME}:${IMAGE_TAG} &> /dev/null
    if [ $? == 0 ]
    then
        echo "Container '${CONTAINER_NAME}' running."
    else
        echo "Container '${CONTAINER_NAME}' failed."
    fi
fi
