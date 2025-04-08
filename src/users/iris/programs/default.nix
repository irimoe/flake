{ inputs, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./fish.nix
    ./starship.nix
    ./zsh.nix
    ./radicle.nix
    ./spicetify.nix
  ];
}
