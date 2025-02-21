{ ... }:

{
  imports = [
    ./xserver.nix
    ./pipewire.nix
  ];

  services = {
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    mpd.enable = true;
    printing.enable = true;
    displayManager.ly.enable = true;
  };
}
