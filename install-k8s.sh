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
cd /srv/kubespray
git checkout -b v2.10.0
cd -

# workaround for calico installation
#sed -i 's/ansible>=2.5.0/ansible==2.6.3/' kubespray/requirements.txt
#cd -
pip install -r /srv/kubespray/requirements.txt


BASE_DIR="/srv/kubespray"
rm -rf ${BASE_DIR}/inventory/mycluster
mkdir -p ${BASE_DIR}/inventory/mycluster
cp -r kubespray/* ${BASE_DIR}/inventory/mycluster/

cp ${BEG_PATH}/node-preconfig.yml ${BASE_DIR}/node-preconfig.yml
cp ${BEG_PATH}/node-postconfig.yml ${BASE_DIR}/node-postconfig.yml

cd ${BASE_DIR}
ansible-playbook -b -i inventory/mycluster/hosts.ini node-preconfig.yml
ansible-playbook -b -i inventory/mycluster/hosts.ini cluster.yml

echo ""
echo " ---------- Kubernetes has been deployed successfully. ---------- "
echo ""

if [ -f ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf ]; then
  ansible-playbook -b -i inventory/mycluster/hosts.ini node-postconfig.yml --extra-vars "kubeconfig=${BASE_DIR}/inventory/mycluster/artifacts/admin.conf"
  
  cp ${BASE_DIR}/inventory/mycluster/artifacts/admin.conf ${BEG_PATH}/kubeconfig/
  chmod 666 ${BEG_PATH}/kubeconfig/admin.conf
  
  echo ""
  echo " ---------- Kubernetes configuration has been saved locally. ---------- "
  echo ""
fi