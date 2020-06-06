{ pkgs ? import <nixpkgs> {} }:

let
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
    busybox
    ranger
  ];
}
