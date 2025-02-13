{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    package = pkgs.foot;

    # enableBashIntegration = true;
    # enableZshIntegration = true;

    settings = {
      main = {
        font = "JetBrainsMono Nerd Font";
        pad = "4x4";
      };
      cursor = {
        style = "beam";
      };
      colors = {
        alpha = 0.8;
        background = "141414";
      };
    };
  };
}
