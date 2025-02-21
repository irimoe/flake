{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    package = pkgs.foot;

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
        background = "0a0a0a";
      };
    };
  };
}
