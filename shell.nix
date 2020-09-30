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
    git
    go
    kubernetes-helm
    python38Full
    python38Packages.bash_kernel
    python38Packages.jupyterlab
  ];

  GIT_SSL_CAINFO = "/etc/ssl/certs/ca-bundle.crt";
  SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";

  shellHook = ''
    mkdir -p ./go
    export GOPATH=$(pwd)/go

    rm -f ./custom-notebook-img/cue
    cp ${pkgs.cue}/bin/cue ./custom-notebook-img/cue

    go get -u k8s.io/api/core/v1
    go get -u k8s.io/api/apps/v1
    # Without go get'ing cmd cue, 
    # not all types work well
    go get -u cuelang.org/go/cmd/cue
    cue get go k8s.io/api/core/v1
    cue get go k8s.io/api/apps/v1
  '';
}
