{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    libsForQt5.polkit-kde-agent
    wirelesstools
    fuse3
    wlroots
    libnotify
    imagemagick
    wl-clipboard
    zellij
  ];
}
