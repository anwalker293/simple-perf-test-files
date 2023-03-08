#!/bin/bash

echo "Before continuing, make sure you modify your firewall rules"
sleep 2

# Mount disks
cd ~
git clone git@github.com:dbluhm/indy-network-bootstrap.git
cd /var/lib
sudo mkdir docker
cd ../../home/anwalker293
sleep 2 

# Disks
echo "Formatting and mounting disks"
sleep 2
sudo mkfs.ext4 -m 0 -F -E lazy_itable_init=0,lazy_journal_init=0,discard /dev/sdb
sudo mount -o discard,defaults /dev/sdb /mnt
sudo mkdir /mnt/home
sudo chown 1001:1001 /mnt/home
sudo mkdir /mnt/docker
sudo mount -o bind /mnt/docker /var/lib/docker
sudo chmod 755 /mnt
sudo mv acapy-perf-testing/ /mnt
# Assuming this is for present proof
sudo mv indy-network-bootstrap/ /mnt

# Installation
# Docker
echo "Installing docker"
sleep 2
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -m 0755 -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Python
sudo apt install software-properties-common
sudo apt install python3

# Poetry?
curl -sSL https://install.python-poetry.org | python3 -
