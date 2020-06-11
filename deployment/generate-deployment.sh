#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

helm template jupyterhub/jupyterhub \
  --name-template '0.0.5' \
  --namespace 'cue-lang-demo' \
  --values ./config.yaml \
  > ./cue-lang-demo.deployment.yaml
