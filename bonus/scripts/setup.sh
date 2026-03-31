#!/bin/bash
set -e

source config/.env

k3d cluster create $K3D_CLUSTER_NAME -c config/k3d.yaml

kubectl apply -f config/namespace.yaml

helm install gitlab gitlab/gitlab \
  --set global.edition=ce \
  --set global.hosts.domain=example.com \
  --set global.hosts.externalIP=0.0.0.0 \
  --set global.hosts.https=false \
  --set global.hosts.gitlab.https=false \
  --set certmanager-issuer.email=me@example.com \
  --set gitlab-runner.install=false \
  --namespace gitlab

sudo bash .script/create_repository.sh

kubectl apply -f config/ingress.yaml

kubectl apply -n argocd --server-side --force-conflicts -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl -n argocd patch deployment argocd-server \
  --type='json' \
  -p='[{"op": "add", "path": "/spec/template/spec/containers/0/args/-", "value":"--insecure"}]'

kubectl apply -f config/application.yaml


