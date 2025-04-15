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
    (callPackage ../../../../pkgs/derivations/sylph.nix { })
    (callPackage ../../../../pkgs/derivations/swaync.nix { })
    wayfreeze
    slurp
    grim
    swww

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
