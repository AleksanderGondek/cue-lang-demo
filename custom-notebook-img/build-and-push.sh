#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

docker build --no-cache -t aleksandergondek/bash-nix-notebook:latest -f notebook-nix-bash.dockerfile .
docker push aleksandergondek/bash-nix-notebook:latest
