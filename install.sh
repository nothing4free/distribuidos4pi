#!/bin/bash

sudo dphys-swapfile swapoff
sudo dphys-swapfile uninstall
sudo update-rc.d dphys-swapfile remove
sudo rm -f /etc/init.d/dphys-swapfile

sudo service dphys-swapfile stop
sudo systemctl disable dphys-swapfile.service

sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt update

sudo apt-get install -y kubectl kubeadm kubernetes-cni docker.io conntrack
sudo mkdir /etc/sysctl.d
sudo mkdir /etc/docker
sudo mv ./kubernetes.conf /etc/sysctl.d/kubernetes.conf
sudo mv ./daemon.json /etc/docker/daemon.json

sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl enable docker.service
sudo systemctl enable kubelet.service
