#! /bin/dash

# Based on the commands from the NVidia Docker Installation Guide.
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html

# Setup the package repository and the GPG key.
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# Install the nvidia-docker2 package and dependencies.
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# Run the test program.
sudo docker run --rm --gpus all nvidia/cuda:11.0.3-base-ubuntu20.04 nvidia-smi

echo "Did you see the NVIDA-SMI output with version numbers?"
echo "If so, you're done.  If not, Google is your friend!"
