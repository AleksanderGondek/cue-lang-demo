#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

docker build --no-cache -t aleksandergondek/jupyter-docker-stacks:cue -f notebook-cue.dockerfile .
docker push aleksandergondek/jupyter-docker-stacks:cue
