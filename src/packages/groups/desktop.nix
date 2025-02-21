{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # wayland utilities
    grim
    slurp
    wl-clipboard
    foot
    fuzzel

    # applications
    discord
    thunderbird
    nextcloud-client
    youtube-music
    keepassxc

    # obs studio and plugins
    obs-studio
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.wlrobs
  ];
}
