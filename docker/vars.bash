# Variables for other scripts.

DOCKER_HUB_USER_NAME="real-robotics"
IMAGE_NAME="ros2-kilted"
IMAGE_TAG="1"
CONTAINER_NAME="ros2_kilted"
# Change this if you want to build your code elsewhere on the host.
WORKSPACE_DIR=${HOME}/workspaces/${CONTAINER_NAME}_ws
# DO NOT CHANGE DOCKER_WS_DIR.
# This is the workspace directory inside the docker.
DOCKER_WS_DIR=${HOME}/ws

