#!/bin/bash
# Give the user a prompt on the docker container.
# Only works for one container running.
set -e

docker_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &>/dev/null && pwd )"
. ${docker_dir}/vars.bash

docker exec \
    -it \
    --env="TERM=xterm-256color" \
    --user=ubuntu \
    --workdir=/home/ubuntu/ws \
    ${CONTAINER_NAME} /bin/bash
