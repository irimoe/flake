{ pkgs, ... }:
{
  home.packages = with pkgs; [
    #
    vesktop
    discord
    beeper
    thunderbird

    nextcloud-client
    keepassxc

    # obs
    obs-studio
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.wlrobs

    # desktop environment tools
    wayfreeze
    slurp
    grim

    imv
    mpv
    mpvpaper
    playerctl

    # fetch
    neofetch
    fastfetch
    kittysay
  ];
}
