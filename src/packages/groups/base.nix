{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # utilities
    htop
    wget
    vim
    git
    zsh
    gnome-keyring
    libsecret
    just
    tmux

    libnotify
    imagemagick
    jq
    wlroots
    mpv
    unzip
    file
    playerctl
    gnupg
    mpv
    mpvpaper

    # system information
    neofetch
    fastfetch
    kittysay
  ];
}
