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
    openssl

    imv
    zellij
    libsForQt5.polkit-kde-agent
    wl-clipboard

    wirelesstools
    fuse3

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

    killall

    # system information
    neofetch
    fastfetch
    kittysay
    hyfetch
  ];
}
