{ pkgs, inputs, ... }:

{
  home.stateVersion = "23.05";
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./desktop
    ./programs
    ./scripts
    ./packages
  ];

  _module.args = { inherit inputs; };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.adwaita-icon-theme;
    size = 24;
    x11 = {
      enable = true;
      defaultCursor = "Adwaita";
    };
  };
}
