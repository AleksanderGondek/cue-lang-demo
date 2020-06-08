#!/usr/bin/env bash

set -o errexit   # abort on nonzero exitstatus
set -o nounset   # abort on unbound variable
set -o pipefail  # don't hide errors within pipes

if [ ! -f /home/jovyan/.nix-channels ]; then
  echo "https://nixos.org/channels/nixpkgs-unstable nixpkgs" > /home/jovyan/.nix-channels
fi

if [ ! -f /home/jovyan/.nix-profile ]; then
  ln -s /nix/var/nix/profiles/per-user/jovyan/profile /home/jovyan/.nix-profile
fi

if [ ! -d /home/jovyan/.nix-defexpr ]; then
  mkdir /home/jovyan/.nix-defexpr
  ln -s /nix/var/nix/profiles/per-user/jovyan/channels /home/jovyan/.nix-defexpr/channels
  ln -s /nix/var/nix/profiles/per-user/root/channels /home/jovyan/.nix-defexpr/channels_root
fi

echo "source /home/jovyan/.nix-profile/etc/profile.d/nix.sh" >> /home/jovyan/.bashrc
