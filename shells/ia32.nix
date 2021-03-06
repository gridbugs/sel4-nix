{ pkgs ? import <nixpkgs> {
  crossSystem = { config = "i686-unknown-linux-gnu"; };
} }:
let
  pythonWithPackages = pkgs.buildPackages.python3.withPackages (pkg: [
    pkg.six
    pkg.future
    pkg.setuptools
    pkg.jinja2
    pkg.ply
    pkg.protobuf
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = [
    pythonWithPackages
    pkgs.buildPackages.git
    pkgs.buildPackages.gitRepo
    pkgs.buildPackages.cacert
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
