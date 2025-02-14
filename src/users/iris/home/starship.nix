{ pkgs, ... }:

{
  programs.starship = {
    enable = true;

    enableZshIntegration = true;
    enableFishIntegration = true;

    settings = pkgs.lib.importTOML ../files/starship.toml;

  };
}
