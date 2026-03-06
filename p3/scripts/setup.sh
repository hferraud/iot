#!/bin/bash
set -e

source config/.env

k3d cluster create $K3D_CLUSTER_NAME -c config/k3d.yaml

kubectl apply -f config/namespace.yaml

kubectl apply -n $NAMESPACE_ARGOCD --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl patch svc argocd-server -n $NAMESPACE_ARGOCD -p '{"spec": {"type": "LoadBalancer"}}'

kubectl apply -f config/application.yaml


