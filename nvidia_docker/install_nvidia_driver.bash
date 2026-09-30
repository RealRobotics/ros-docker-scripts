#!/bin/dash

DISTRO=ubuntu2604
DRIVER_VERSION=595

# Install the NVIDIA driver if it is not already installed.
# From: https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/latest/ubuntu.html
sudo apt update
sudo apt install linux-headers-$(uname -r)

wget https://developer.download.nvidia.com/compute/cuda/repos/$DISTRO/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb

sudo apt install nvidia-open

# Refresh NVIDIA CDI mounts after driver updates.
if ! sudo nvidia-ctk cdi generate --output=/var/run/cdi/nvidia.yaml
then
    echo "Failed to refresh NVIDIA CDI specification."
    exit 1
fi

# Install CUDA Toolkit.  Based on:
# https://docs.nvidia.com/cuda/cuda-installation-guide-linux/#network-repo-installation-for-ubuntu

sudo apt install cuda-toolkit

# Post installation steps
# Mandatory
export PATH=${PATH}:/usr/local/cuda-13.4/bin
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/cuda-13.4/lib64


echo "NVidia driver installation complete.  Please reboot your computer to ensure the driver is loaded."
exit 0
