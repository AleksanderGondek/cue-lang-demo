#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

# Ensure that bash kernel is indeed installed
python -m bash_kernel.install

if [ ! -d /home/jovyan/cue-lang-demo ]; then
  git -c http.sslVerify=false clone https://github.com/AleksanderGondek/cue-lang-demo.git /home/jovyan/cue-lang-demo
fi
