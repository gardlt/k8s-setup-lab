#!/bin/bash


sudo apt-get install ceph-common ceph-fs-common -y

curl -L https://github.com/gliderlabs/sigil/releases/download/v0.4.0/sigil_0.4.0_Linux_x86_64.tgz | sudo tar -zxC /usr/local/bin

export kube_version=v1.6.2

sudo sed -i "s|gcr.io/google_containers/kube-controller-manager-amd64:'$kube_version'|quay.io/attcomdev/kube-controller-manager:'$kube_version'|g" /etc/kubernetes/manifests/kube-controller-manager.yaml



export osd_public_network=10.32.0.0/12
export osd_cluster_network=10.32.0.0/12

helm install --set network.public=$osd_public_network --name=ceph local/ceph --namespace=ceph

helm install --name=bootstrap-ceph local/bootstrap --namespace=ceph
helm install --name=bootstrap-openstack local/bootstrap --namespace=openstack

