{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    enableZshIntegration = true;
    enableFishIntegration = false;

    settings = pkgs.lib.importTOML ../files/starship.toml;
  };
}