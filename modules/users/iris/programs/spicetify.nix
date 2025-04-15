{
  inputs,
  pkgs,
  globalConfig,
  ...
}:
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.catppuccin;
    colorScheme = globalConfig.theme.ctp.getCurrent globalConfig;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      shuffle
      autoSkip
      powerBar
      autoVolume
    ];
  };
}
