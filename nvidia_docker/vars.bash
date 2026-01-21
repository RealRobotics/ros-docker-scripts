# Variables for other scripts.

DOCKER_HUB_USER_NAME="real-robotics"
IMAGE_NAME="ros2-kilted-nvidia"
IMAGE_TAG="1"
CONTAINER_NAME="ros2_kilted_nvidia"
# Change this if you want to build your code elsewhere on the host.
WORKSPACE_DIR=${HOME}/workspaces/${CONTAINER_NAME}_ws
# DO NOT CHANGE DOCKER_WS_DIR.
# This is the workspace directory inside the docker.
DOCKER_WS_DIR=${HOME}/ws
# For the video
XAUTH=/tmp/.docker.xauth
