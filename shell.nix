{ }:

let
  pkgs = import (
    fetchTarball { url = https://github.com/NixOS/nixpkgs/archive/nixos-20.09.tar.gz;}
  ) {};
in
pkgs.mkShell {
  name = "cue-lang-shell";

  buildInputs = with pkgs; [
    cue
    busybox
    docker
    kubernetes-helm
    python38Full
    python38Packages.bash_kernel
    python38Packages.jupyterlab
  ];

  shellHook = ''
    rm -f ./custom-notebook-img/cue
    cp ${pkgs.cue}/bin/cue ./custom-notebook-img/cue
  '';
}
