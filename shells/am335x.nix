{ pkgs ? import <nixpkgs> {
  crossSystem = { config = "arm-none-eabi"; };
} }:
let
  # pyfdt isn't in the nixpkgs repo
  pyfdt = pkgs.buildPackages.python3Packages.buildPythonPackage {
    name = "pydft";
    src = pkgs.python3Packages.fetchPypi {
      pname = "pyfdt";
      version = "0.3";
      sha256 = "sha256:1w7lp421pssfgv901103521qigwb12i6sk68lqjllfgz0lh1qq31";
    };
    propagatedBuildInputs = [];
  };
  pythonWithPackages = pkgs.buildPackages.python3.withPackages (pkg: [
    pkg.six
    pkg.future
    pkg.setuptools
    pkg.jinja2
    pkg.ply
    pkg.protobuf
    pkg.pyaml
    pkg.libarchive-c
    pkg.pyelftools
    pkg.jsonschema
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = [
    pythonWithPackages
    pyfdt
    pkgs.buildPackages.git
    pkgs.buildPackages.gitRepo
    pkgs.buildPackages.cacert
    pkgs.buildPackages.cmake
    pkgs.buildPackages.ninja
    pkgs.buildPackages.libxml2
    pkgs.buildPackages.protobuf
    pkgs.buildPackages.binutils
    pkgs.buildPackages.gcc
    pkgs.buildPackages.dtc
    pkgs.buildPackages.cpio
    pkgs.buildPackages.ubootTools
    pkgs.buildPackages.qemu
    pkgs.buildPackages.ncurses
  ];
}
