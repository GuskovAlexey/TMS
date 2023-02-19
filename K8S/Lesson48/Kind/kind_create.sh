#! /bin/env bash
export DOCKER_HOST_IP="172.31.16.121"
export DOCKER_HOST_EXTERNAL_IP="3.70.155.191"
export POD_SUBNET="10.240.0.0/16"
export SERVICE_SUBNET="10.0.0.0/16"
export VOLUME_HOST_PATH="/tmp/data/"
export VOLUME_CONTAINER_PATH="/data"

# create kind cluster
envsubst < config.yaml | kind create cluster --config=-

# add external ip docker-machine into kubeconfig
echo "Edit kube config file..."
sed -i "s/$DOCKER_HOST_IP/$DOCKER_HOST_EXTERNAL_IP/g" ~/.kube/config

