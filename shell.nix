{ pkgs ? import <nixpkgs> {} }:

let
  # For some reason, fetchTarball has a hash clash (!?)
  latest_cue = pkgs.fetchurl { 
    url = "https://github.com/cuelang/cue/releases/download/v0.2.0/cue_0.2.0_Linux_x86_64.tar.gz";
    sha256 = "1mbkyd4148lfh3iaaj00nmk2adjficdlc2mi1cfzxqs8mg459i1n";
  };
  unstable = import (
    fetchTarball { url = https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz;}
  ) {
    config = pkgs.config;
  };
in
pkgs.mkShell {
  name = "cue-lang-shell";

  buildInputs = with pkgs; [
    unstable.kubernetes-helm
    # Cue is in quite old version on unstable channel
    #unstable.cue
    busybox
    docker
    python38Full
    python38Packages.bash_kernel
    python38Packages.jupyterlab
  ];

  shellHook = ''
    rm -f ./custom-notebook-img/cue
    tar -zxvf ${latest_cue} cue
    mv ./cue ./custom-notebook-img/cue

    python -m bash_kernel.install

    export PATH=$PATH:$(pwd)/custom-notebook-img
  '';
}
