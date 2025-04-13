{
  pkgs ? import <nixpkgs> { },
}:

let
  src = pkgs.fetchFromGitHub {
    owner = "irimoe";
    repo = "sylph";
    rev = "68df0d8a253bcb8e30ecd32e9a817aba4ca01c4e";
    sha256 = "sha256-MZOjFoGG9uU/3BYniH8sRa2HQsoz2OsoLeqNMccW0AY=";
  };
in
pkgs.rustPlatform.buildRustPackage {
  pname = "sylph";
  version = "0.1.0";
  inherit src;
  cargoLock = {
    lockFileContents = builtins.readFile "${src}/Cargo.lock";
  };
  nativeBuildInputs = with pkgs; [
    pkg-config
    esbuild
  ];
  buildInputs = with pkgs; [
    openssl
    gtk3
    libsoup_3
    gtk-layer-shell
    webkitgtk_4_1
  ];
}
