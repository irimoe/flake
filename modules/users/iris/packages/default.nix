{ pkgs, ... }:

{
  imports = [
    ./desktop.nix
    ./dev.nix
  ];

  # misc stuff.
  home.packages = with pkgs; [
    spicetify-cli
    prismlauncher
  ];

}
