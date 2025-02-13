{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
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
