# Variables for other scripts.

DOCKER_HUB_USER_NAME="pipebots"
IMAGE_NAME="ros2-pipebot"
IMAGE_TAG="1"
CONTAINER_NAME="ros2_pipebot"
# Change this if you want to build your code elsewhere on the host.
WORKSPACE_DIR=${HOME}/pipebot_ws
# DO NOT CHANGE DOCKER_WS_DIR.
# This is the workspace directory inside the docker.
DOCKER_WS_DIR=${HOME}/ws

# PC script vars
UBUNTU_RELEASE=focal
# Needed during builds.
ROS_PYTHON_VERSION=3
ROS2_DISTRO=foxy
# Colcon workspace directories.
COLCON_WS_DIR=${DOCKER_WS_DIR}
COLCON_SRC_DIR=${COLCON_WS_DIR}/src
