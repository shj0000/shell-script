#! /bin/bash

echo start
# https://www.linuxtechi.com/install-kubernetes-on-ubuntu-22-04/
# Step 1) Set hostname and add entries in the hosts file
# sudo hostnamectl set-hostname "k8smaster.example.net"
# exec bash

# Step 2) Disable swap & add kernel settings
# Execute beneath swapoff and sed command to disable swap. Make sure to run the following commands on all the nodes.
sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# Load the following kernel modules on all the nodes,
cat <<EOF > /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF


sudo modprobe overlay
sudo modprobe br_netfilter

# Set the following Kernel parameters for Kubernetes, run beneath tee command
cat <<EOF > /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF


# Reload the above changes, run
sudo sysctl --system

# Step 3) Install containerd run time
# Install containerd run time
# In this guide, we are using containerd run time for our Kubernetes cluster. So, to install containerd, first install its dependencies.
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

# Enable docker repository
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# Now, run following apt command to install containerd
sudo apt update
sudo apt install -y containerd.io

# Configure containerd so that it starts using systemd as cgroup.
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

# Restart and enable containerd service
sudo systemctl restart containerd
sudo systemctl enable containerd

# Step 4) Add apt repository for Kubernetes
# Execute following commands to add apt repository for Kubernetes
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

# Step 5) Install Kubernetes components Kubectl, kubeadm & kubelet
# Install Kubernetes components Kubectl, kubeadm & kubelet
sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

# Step 6) Initialize Kubernetes cluster with Kubeadm command
# sudo kubeadm init --control-plane-endpoint=k8smaster.example.net

# So, to start interacting with cluster, run following commands from the master node,
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Now, try to run following kubectl commands to view cluster and node status
kubectl cluster-info
kubectl get nodes







