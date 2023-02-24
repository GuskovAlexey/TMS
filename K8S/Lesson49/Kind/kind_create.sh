
#! /bin/env bash
export DOCKER_HOST_IP="172.31.24.204"
export DOCKER_HOST_EXTERNAL_IP="18.170.52.49"
export POD_SUBNET="10.240.0.0/16"
export SERVICE_SUBNET="10.0.0.0/16"
export VOLUME_NODE1_HOST="/tmp/data-worker/"
export VOLUME_NODE1_CONTAINER="/data"
export VOLUME_NODE2_HOST="/tmp/data-worker2/"
export VOLUME_NODE2_CONTAINER="/data"

# create kind cluster
envsubst < config.yaml | kind create cluster --config=-

# add external ip docker-machine into kubeconfig
echo "Edit kube config file..."
sed -i "s/$DOCKER_HOST_IP/$DOCKER_HOST_EXTERNAL_IP/g" ~/.kube/config

# install Calico
echo "Install Calico CNI..."
kubectl --insecure-skip-tls-verify apply -f calico.yaml
# curl https://docs.projectcalico.org/manifests/calico.yaml | kubectl --insecure-skip-tls-verify apply -f -

# scale down CoreDNS
echo "Scale down coreNDS..."
kubectl --insecure-skip-tls-verify scale deployment --replicas 1 coredns --namespace kube-system

# get kubernetes cluster info
kubectl --insecure-skip-tls-verify cluster-info

# change pod for kubectl top and for hpa that to work
kubectl --insecure-skip-tls-verify apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml


# alias kubectl='kubectl --insecure-skip-tls-verify' 