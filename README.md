# shell-script

## cmd

### Alias 적용
* `( wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/update_alias.sh | bash ) && source ~/.bash_aliases`

### History
* apply timestamp
* max history 증가

### Install

#### k8s

##### worker node

* `wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/install_k8s_worker_node.sh | bash`

* 추가 과정 (y 자동 설정 )
```bash
The following package was automatically installed and is no longer required:
  systemd-hwe-hwdb
Use 'apt autoremove' to remove it.
0 upgraded, 0 newly installed, 0 to remove and 156 not upgraded.
File '/etc/apt/keyrings/docker.gpg' exists. Overwrite? (y/N) y
```

* 추가 과정 (통합 필요, 인자 설정)
```bash
## join
kubeadm join 192.168.0.18:6443 --token 08ypuq.0j42qn5l0tsxj2ra \
        --discovery-token-ca-cert-hash sha256:7a92f3dfe9bcb1aca564854801349e9b8b70a216fb5499e25ce2d7b071725cad \
	--cri-socket unix:///var/run/cri-dockerd.sock

## network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```
