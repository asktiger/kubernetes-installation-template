#!/bin/bash

# install docker
#sudo apt-get -y install apt-transport-https ca-certificates curl software-properties-common
#curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
#sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo wget https://download.docker.com/linux/centos/docker-ce.repo
sudo mv ./docker-ce.repo /etc/yum.repos.d/
sudo yum update -y
sudo yum install -y docker-ce

sudo systemctl enable docker && systemctl start docker
sudo docker run --rm -v $(pwd):/k8s-deploy centos:7.5.1804 bash -c "cd /k8s-deploy; bash install-k8s.sh"
