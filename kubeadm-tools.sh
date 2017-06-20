
export KUBE_VERSION=v1.6.2

apt-get update && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update

sudo apt-get install -y kubelet kubeadm kubectl kubernetes-cni

curl -sSLo ksl.tar.gz https://dl.k8s.io/${KUBE_VERSION}/kubernetes-server-linux-amd64.tar.gz
tar -xvf ksl.tar.gz

mv kubernetes/server/bin/kubelet /usr/bin/kubelet
mv kubernetes/server/bin/kubeadm /usr/bin/kubeadm
chmod +x /usr/bin/kubelet
chmod +x /usr/bin/kubeadm
