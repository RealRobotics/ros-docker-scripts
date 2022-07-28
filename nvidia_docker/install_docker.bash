#!/bin/bash
# From: https://docs.docker.com/install/linux/docker-ce/ubuntu/#set-up-the-repository

set -e

echo "If this script fails at any time, run the remaining commands from this file using copy and paste."

# Update the apt package index:
sudo apt-get update

# Install packages to allow apt to use a repository over HTTPS:
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key:
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Verify that you now have the key with the fingerprint
# 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last
# 8 characters of the fingerprint.
sudo apt-key fingerprint 0EBFCD88

#pub   4096R/0EBFCD88 2017-02-22
#      Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
#uid                  Docker Release (CE deb) <docker@docker.com>
#sub   4096R/F273FCD8 2017-02-22

# Use the following command to set up the stable repository. You always need
# the stable repository, even if you want to install builds from the edge or
# test repositories as well. To add the edge or test repository, add the
# word edge or test (or both) after the word stable in the commands below.
# Note: The lsb_release -cs sub-command below returns the name of your Ubuntu
# distribution, such as xenial. Sometimes, in a distribution like Linux Mint,
# you might need to change $(lsb_release -cs) to your parent Ubuntu
# distribution. For example, if you are using Linux Mint Rafaela, you could
# use trusty.
# x86_64 / amd64
# armhf
# IBM Power (ppc64le)
# IBM Z (s390x)
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"


# Update the apt package index:
sudo apt-get update

# Install the latest version of Docker CE.
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Add the current user to the docker group
sudo groupadd docker
sudo usermod -aG docker ${USER}

echo "Please log out and log in again to use docker as yourself (not sudo)."
