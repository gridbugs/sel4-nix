{ pkgs ? import <nixpkgs> {
  crossSystem = { config = "i686-unknown-linux-gnu"; };
} }:
let
  pythonWithPackages = pkgs.buildPackages.python3.withPackages (pkg: with pkg; [
    six
    future
    setuptools
    jinja2
    ply
    protobuf
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = [
    pythonWithPackages
    pkgs.buildPackages.git
    pkgs.buildPackages.gitRepo
    pkgs.buildPackages.cmake
    pkgs.buildPackages.ninja
    pkgs.buildPackages.libxml2
    pkgs.buildPackages.protobuf
    pkgs.buildPackages.gcc
    pkgs.buildPackages.cpio
    pkgs.buildPackages.qemu
    pkgs.buildPackages.ncurses
  ];
}
