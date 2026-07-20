#! /bin/dash

#  Fix the Host NVIDIA Container Toolkit.
sudo nvidia-ctk runtime configure --runtime=docker --set-as-default
sudo systemctl restart docker

# Install the nvidia-docker2 package and dependencies.
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker

# 1. Add the package repositories
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg
curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

# 2. Update and install
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

# 3. Configure the Docker runtime and restart the service
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker

# Run the test program.
sudo docker run --rm --runtime=nvidia --gpus all ubuntu nvidia-smi

echo "Did you see the NVIDA-SMI output with version numbers?"
echo "If so, you're done.  If not, Google is your friend!"
