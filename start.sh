#!/bin/bash

# install docker
sudo wget https://download.docker.com/linux/centos/docker-ce.repo
sudo mv ./docker-ce.repo /etc/yum.repos.d/
sudo yum update -y
sudo yum install -y docker-ce

sudo systemctl enable docker && systemctl start docker
sudo docker run --rm -v $(pwd):/k8s-deploy centos:7.8.2003 bash -c "cd /k8s-deploy; bash install-k8s.sh"
