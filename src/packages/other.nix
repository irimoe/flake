{ pkgs, ... }:
let
  bun = pkgs.callPackage ./bun.nix { };
in
{
  environment.systemPackages = with pkgs; [
    bun
    unzip
    file

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
    zed-editor
    mpv
    mpvpaper
  ];
}
