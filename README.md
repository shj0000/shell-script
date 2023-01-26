# shell-script

## cmd

### Alias 적용
* `( wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/update_alias.sh | bash ) && source ~/.bash_aliases`

### History
* apply timestamp
* max history 증가

### Install

#### k8s (Ubuntu 22)

##### master node
* ...

##### worker node

* `wget -O - https://raw.githubusercontent.com/shj0000/shell-script/main/sh/install_k8s_worker_node.sh | bash`


* 추가 과정 (통합 필요, 인자 설정)
```bash
## find token
kubeadm token create
kubeadm token list

## find hash
openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //'

## join
kubeadm join 192.168.0.18:6443 --token 08ypuq.0j42qn5l0tsxj2ra \
        --discovery-token-ca-cert-hash sha256:7a92f3dfe9bcb1aca564854801349e9b8b70a216fb5499e25ce2d7b071725cad \
	--cri-socket unix:///var/run/cri-dockerd.sock

## network
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```

