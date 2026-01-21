#! /bin/dash

# Based on the commands from the NVidia Docker Installation Guide.
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

sudo apt update && sudo apt install -y --no-install-recommends \
   curl \
   gnupg2

# Setup the package repository and the GPG key.
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install the NVIDIA Container Toolkit packages
sudo apt update
export NVIDIA_CONTAINER_TOOLKIT_VERSION=1.18.0-1
  sudo apt install -y \
      nvidia-container-toolkit=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      nvidia-container-toolkit-base=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container-tools=${NVIDIA_CONTAINER_TOOLKIT_VERSION} \
      libnvidia-container1=${NVIDIA_CONTAINER_TOOLKIT_VERSION}

# Configure Docker
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Verify the installation by running a sample workload.
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/1.18.1/sample-workload.html
echo
echo "Verifying the installation by running a sample workload..."
echo
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

echo
echo "Did you see the NVIDIA-SMI output with version numbers?"
echo "If so, you're done.  If not, Google is your friend!"
