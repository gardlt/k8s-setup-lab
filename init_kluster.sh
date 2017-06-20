#!/bin/bash

LOCAL_IP=$(ip addr | awk '/inet/ && /ens3/{sub(/\/.*$/,"",$2); print $2}')
cat << EOF | sudo tee -a /etc/hosts
${LOCAL_IP} $(hostname)
EOF

echo "nameserver 10.96.0.10" >> /etc/resolvconf/resolv.conf.d/head
echo "nameserver 8.8.8.8" >> /etc/resolvconf/resolv.conf.d/head
echo "search openstack.svc.cluster.local svc.cluster.local cluster.local" >> /etc/resolvconf/resolv.conf.d/tail

sudo resolvconf -u

sudo apt install -y docker.io make

#k8s-cluster-admin kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local
