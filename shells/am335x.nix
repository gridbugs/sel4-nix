{
  pkgsNative ? import <nixpkgs> {},
  pkgsCross ? import <nixpkgs> {
    crossSystem = { config = "arm-none-eabi"; };
  },
}:
let
  # pyfdt isn't in the nixpkgs repo
  pyfdt = pkgsNative.python3Packages.buildPythonPackage {
    name = "pydft";
    src = pkgsNative.python3Packages.fetchPypi {
      pname = "pyfdt";
      version = "0.3";
      sha256 = "sha256:1w7lp421pssfgv901103521qigwb12i6sk68lqjllfgz0lh1qq31";
    };
    propagatedBuildInputs = [];
  };
  pythonWithPackages = pkgsNative.python3.withPackages (pkg: [
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
pkgsNative.mkShell {
  nativeBuildInputs = [
    pythonWithPackages
    pyfdt
  ] ++ (with pkgsNative; [
    git
    gitRepo
    cacert
    cmake
    ninja
    libxml2
    protobuf
    dtc
    cpio
    ubootTools
    qemu
    ncurses
  ]) ++ (with pkgsCross.buildPackages; [
    binutils
    gcc
  ]);
}
