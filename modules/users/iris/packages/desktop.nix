{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # desktop environment tools
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
