{ ... }:

{
  imports = [
    ./xserver.nix
    ./flatpak.nix
    ./gnome-keyring.nix
    ./printing.nix
    ./pipewire.nix
  ];
}
