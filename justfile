# show available commands
_default:
  @just --list --unsorted

# build the system configuration
build *args:
    sudo nixos-rebuild build --flake . {{args}}

# apply the system configuration
switch *args:
    sudo nixos-rebuild switch --flake . {{args}}

# test configuration without applying
dry-switch *args:
    sudo nixos-rebuild dry-activate --flake . {{args}}

# update flake inputs
update *args:
    nix flake update --extra-experimental-features nix-command --extra-experimental-features flakes {{args}}

# check flake for errors
check *args:
    nix flake check --extra-experimental-features nix-command --extra-experimental-features flakes {{args}}

# generate hardware config for a new host
hardware-config host="nixos":
    sudo nixos-generate-config --dir ./hosts/{{host}}

# run garbage collection
gc:
    nix-collect-garbage -d

# get current nixos version
version:
    nixos-version

# update home-manager configuration only
home *args:
    home-manager switch --flake .#iris@nixos {{args}}

# clean old system generations
clean generations="7d":
    sudo nix-collect-garbage --delete-older-than {{generations}}
    sudo nix-store --gc
    sudo /run/current-system/bin/switch-to-configuration switch