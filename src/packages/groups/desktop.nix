{ pkgs, derivations, ... }:
{
  environment.systemPackages = with pkgs; [
    derivations.zen-browser

    spicetify-cli
    prismlauncher

    # wayland utilities
    grim
    slurp
    wl-clipboard
    foot
    fuzzel
    beeper

    # applications
    discord
    vesktop
    thunderbird
    nextcloud-client
    youtube-music
    keepassxc

    hyprpicker
    google-chrome

    # obs studio and plugins
    obs-studio
    obs-studio-plugins.obs-vkcapture
    obs-studio-plugins.obs-pipewire-audio-capture
    obs-studio-plugins.wlrobs
  ];
}
