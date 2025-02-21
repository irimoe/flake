{ pkgs, derivations, ... }:
{
  environment.systemPackages = with pkgs; [
    derivations.zed-editor
    derivations.bun

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
