# shell-script

## cmd

### Alias 적용

* Commons
```
curl -s https://raw.githubusercontent.com/shj0000/shell-script/main/file/aliases/common/.bash_aliases > ~/.bash_aliases && \
source ~/.bash_aliases
```

* Commons + k8s
```
( wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/update_alias.sh | bash ) && source ~/.bash_aliases
```

### History
* Add timestamp to Linux history
* Append history immediately after each command
* Change max history size
* Write Tmp Log File With IP > $(who am i)
```
( wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/add_timestamp_history.sh | sudo bash ) && bash
```

### Crontab > Auto Remove
* ...

### Install

#### docker (centos 7)
```
wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/cent_os_install_docker.sh | sudo bash
```

```
curl -s https://raw.githubusercontent.com/shj0000/shell-script/main/sh/cent_os_install_docker.sh | sudo bash -s
```

#### k8s (Ubuntu 22)

##### master node
```
( wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/install_k8s_master_node.sh | bash > ./install_k8s_master.log ) 
```
```bash
kubeadm init --pod-network-cidr=10.0.0.0/16 \
   --cri-socket unix:///var/run/cri-dockerd.sock \
   --apiserver-advertise-address=10.0.0.197 \
   --pod-network-cidr=10.244.0.0/16 \ 
   --v=5

kubeadm reset  --cri-socket unix:///var/run/cri-dockerd.sock


```


##### worker node
```
( wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/install_k8s_worker_node.sh | bash ) > ./install_k8s_worker.log
```

* https://stackoverflow.com/questions/55725477/authenticated-as-anonymous-groups-that-you-are-in-error-when-checking-kubectl
* 추가 과정 (통합 필요, 인자 설정)
```bash
## find token
kubeadm token create
kubeadm token list

## find hash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

## reset 
kubeadm reset --cri-socket unix:///var/run/cri-dockerd.sock


## join
kubeadm join 192.168.0.18:6443 --token 08ypuq.0j42qn5l0tsxj2ra \
        --discovery-token-ca-cert-hash sha256:7a92f3dfe9bcb1aca564854801349e9b8b70a216fb5499e25ce2d7b071725cad \
	--cri-socket unix:///var/run/cri-dockerd.sock --v=5

## network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

