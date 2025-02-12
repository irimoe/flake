_default:
  @just --list --unsorted

build *args:
    sudo nixos-rebuild build --flake . {{args}}

switch *args:
    sudo nixos-rebuild switch --flake . {{args}}

dry-switch *args:
    sudo nixos-rebuild dry-activate --flake . {{args}}

update:
    nix flake update

check *args:
    nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes {{args}}

hardware-config:
    sudo nixos-generate-config --dir ./src

gc:
    nix-collect-garbage -d

version:
    nixos-version
