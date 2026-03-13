#!/bin/bash

set -e

NAMESPACE="gitlab"
REPO_NAME="iot_deployment_hferraud"
GITHUB_REPO="https://github.com/hferraud/${REPO_NAME}.git"
GITLAB_REPO="http://gitlab.example.com/root/${REPO_NAME}.git"
WORKDIR="/tmp/${REPO_NAME}"

GITLAB_TOOLBOX_POD=$(kubectl get pods -n ${NAMESPACE} -l app=toolbox -o jsonpath='{.items[0].metadata.name}')

GITLAB_PAT=$(kubectl exec -n ${NAMESPACE} $GITLAB_TOOLBOX_POD -- gitlab-rails runner \
  "t = User.find_by_username('root').personal_access_tokens.create(
    name: 'script-token3',
    scopes: ['api', 'write_repository', 'read_repository'],
    expires_at: 1.year.from_now
  ); puts t.errors.any? ? t.errors.full_messages : t.token")

curl --request POST "http://gitlab.example.com/api/v4/projects" \
--header "PRIVATE-TOKEN: $GITLAB_PAT" \
--header "Content-Type: application/json" \
--data '{"name": "iot_deployment_hferraud", "visibility": "public"}'

rm -rf ${WORKDIR}
git clone ${GITHUB_REPO} ${WORKDIR}
cd ${WORKDIR}
git remote set-url origin http://root:${GITLAB_PAT}@gitlab.example.com/root/${REPO_NAME}
git push origin main

