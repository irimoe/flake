{ pkgs, globalConfig, ... }:
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
        color = "eff1f5 dc8a78";
      };
      colors = globalConfig.theme.ctp.footColours.${globalConfig.theme.ctp.getCurrent globalConfig};
    };
  };
}
