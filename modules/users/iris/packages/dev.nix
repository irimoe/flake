{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.callPackage ../../../../pkgs/derivations/zed-editor.nix { })
    (pkgs.callPackage ../../../../pkgs/derivations/zed-editor-preview.nix { })
    (pkgs.callPackage ../../../../pkgs/derivations/bun.nix { })

    wayfreeze
    sqlitebrowser
    temurin-bin-23

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
