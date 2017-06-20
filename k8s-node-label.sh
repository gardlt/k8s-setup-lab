

#!/bin/bash

kubectl create -f https://rawgit.com/kubernetes/dashboard/master/src/deploy/kubernetes-dashboard.yaml
kubectl update -f https://raw.githubusercontent.com/openstack/openstack-helm/master/tools/kubeadm-aio/assets/opt/rbac/dev.yaml
kubectl apply -f https://git.io/weave-kube-1.6
kubectl apply --namespace kube-system -f "https://cloud.weave.works/k8s/scope.yaml?k8s-version=$(kubectl version | base64 | tr -d '\n')"

for i in $(kubectl get nodes | grep kubeadm-slave | awk '{print $1}');
do
	echo $i
	kubectl label nodes $i openstack-control-plane=enabled
	kubectl label nodes $i ceph-storage=enabled
	kubectl label nodes $i openvswitch=enabled
	kubectl label nodes $i openstack-compute-node=enabled
	kubectl label nodes $i openstack-control-plane=enabled

done
