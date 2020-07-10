# kubernetes-installation-template

This is an Kubernetes installation template for Kubespray


# Prerequisites

1. All the VMs for deploying Kubernetes needs to be accessible via specific private SSH key

2. Prepare an CentOS 7.5 later machine for deployment(VM is fine)


# User Guide

## Clone this repository

Log in the deployment machine and execute the following commands:

```bash
$ sudo yum update
$ sudo yum -y install git
$ cd /tmp
$ git clone https://github.com/asktiger/kubernetes-installation-template.git
```


## Prepare SSH access key

Put the private SSH access key to **/tmp/kubernetes-installation-template/ssh-privkey** folder.


## Change the default deployment configurations

The following configurations are necessary to change according to your environment:

### /tmp/kubernetes-installation-template/kubespray/group_vars/all.yml

- **Host Authentication Information**

> This part includes the authentication information of the hosts which are going to deploy

- **Python Interpreter Location**

> File path of Python Interpreter which is required for Ansible deployment

- Bootstrap OS

> default is set to `centos`，modification is needed if different OS is used

### /tmp/kubernetes-installation-template/kubespray/hosts.ini

Fill out the inventory information of the nodes which are going to deploy Kubernetes. There are two kinds of information is need here:

- Host information: includes **OS hostname** and **IP address**

- Host Roles (which nodes is belong to **master**, **worker**)



## Start to deploy

Execute the following commands to start Kubernetes deployment:

```bash
$ cd kubernetes-installation-template/
$ bash start.sh
```


## Access the Kubernetes cluster

Log in any one of the master nodes you defined in the file **/tmp/kubernetes-installation-template/kubespray/hosts.ini**，**kubectl** CLI is installed and be able to manage the cluster.
