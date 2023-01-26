#! /bin/bash

# br_netfilter 모듈 로드
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

# 커널 파라미터 수정
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# sysctl 파라미터 적용
sysctl --system

# HTTPS로 저장소를 사용하기 위한 패키지 설치
apt update
apt install ca-certificates curl gnupg lsb-release

# Docker GPG Key 추가
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --batch --yes --dearmor -o /etc/apt/keyrings/docker.gpg

# 레포지터리 설정
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
# 도커 엔진 설치
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 도커 설치 확인
docker version

# ? https://passwd.tistory.com/entry/kubeadmcri-dockerd-Kubernetes-%EC%84%A4%EC%B9%98-%ED%81%B4%EB%9F%AC%EC%8A%A4%ED%84%B0-%EC%83%9D%EC%84%B1 


# 쿠버네티스 1.24부터는 Docker Container Runtime이 쿠버네티스와 호환되지 않아 cri-dockerd 설치가 추가로 필요하다.
# https://github.com/Mirantis/cri-dockerd

## git clone
git clone https://github.com/Mirantis/cri-dockerd.git
## install
# Run these commands as root
###Install GO###
wget https://storage.googleapis.com/golang/getgo/installer_linux -O ./installer_linux
chmod +x ./installer_linux
./installer_linux
source ~/.bash_profile

cd cri-dockerd
mkdir bin
go build -o bin/cri-dockerd
mkdir -p /usr/local/bin
install -o root -g root -m 0755 bin/cri-dockerd /usr/local/bin/cri-dockerd
cp -a packaging/systemd/* /etc/systemd/system
sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
systemctl daemon-reload
systemctl enable cri-docker.service
systemctl enable --now cri-docker.socket

# cri-docker 시작
systemctl daemon-reload
systemctl enable --now cri-docker
# systemctl status cri-docker

# 쿠버네티스 레포지터리를 사용하기 위한 패키지 설치
apt install apt-transport-https ca-certificates curl

# 공개 사이닝 키설정
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg

# 쿠버네티스 레포지터리 추가
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

# 설치
apt update
apt install kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# 설치 확인
kubeadm version
kubelet --version
kubectl version
