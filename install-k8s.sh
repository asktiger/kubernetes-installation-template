#!/bin/bash

# upgrade pip
yum install -y epel-release
yum install -y python-pip python36 python-netaddr python36-pip python-devel git wget zip \
               lrzsz net-tools cracklib-dicts-2.9.0-11.el7 libselinux-python device-mapper-libs \
               python-httplib2 openssl rsync bash-completion socat unzip sshpass
yum update -y
pip install --upgrade pip


rm -rf /srv/kubespray
cd /srv
git clone https://github.com/kubernetes-incubator/kubespray.git
# workaround for calico installation
sed -i 's/ansible>=2.5.0/ansible==2.6.3/' kubespray/requirements.txt
cd -
pip install -r /srv/kubespray/requirements.txt


BASE_DIR="/srv/kubespray"
rm -rf ${BASE_DIR}/inventory/mycluster
mkdir -p ${BASE_DIR}/inventory/mycluster
cp -r kubespray/* ${BASE_DIR}/inventory/mycluster/

cd ${BASE_DIR}
ansible-playbook -b -i inventory/mycluster/hosts.ini cluster.yml
cd -
if [ -f ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf ]; then
  cp ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf kubeconfig/
fi
