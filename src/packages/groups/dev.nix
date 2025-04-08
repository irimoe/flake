{ pkgs, derivations, ... }:
{
  environment.systemPackages = with pkgs; [
    derivations.zed-editor
    derivations.zed-preview
    derivations.bun

    wayfreeze
    sqlitebrowser

    temurin-jre-bin-23
    temurin-jre-bin-8

    nmap

    forgejo-runner
    go

    nodejs_23
    dig
    sqlite

    gcc
    glibc

    # rust
    cargo
    rustc
    rustfmt
    rust-analyzer

    # nix
    nil
    nixd
    nixfmt-rfc-style
  ];
}
