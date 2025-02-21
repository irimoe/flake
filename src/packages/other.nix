{ pkgs, ... }:
let
  bun = pkgs.callPackage ./bun.nix { };
  zeditor = pkgs.callPackage ./zed-editor.nix { };
in
{
  environment.systemPackages = with pkgs; [
    bun
    zeditor

    libnotify
    imagemagick
    jq
    wlroots
    mpv

    gcc
    glibc
    cargo
    rustc
    rustfmt
    rust-analyzer

    unzip
    file
    obs-studio
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.wlrobs

    discord
    thunderbird
    nextcloud-client
    nil
    nixd
    nixfmt-rfc-style
    youtube-music
    playerctl
    keepassxc
    gnupg
    mpv
    mpvpaper
  ];
}
