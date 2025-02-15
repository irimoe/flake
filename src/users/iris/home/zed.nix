{
  pkgs,
  lib,
  config,
  ...
}:

let
  jsonFormat = pkgs.formats.json { };
  zed-editor = pkgs.callPackage ../programs/zed-editor.nix { };

  mergedSettings =
    cfg.userSettings
    // (lib.optionalAttrs (builtins.length cfg.extensions > 0) {
      auto_install_extensions = lib.genAttrs cfg.extensions (_: true);
    });

  cfg = config.programs.zed-editor;
in
{
  xdg.configFile."zed/settings.json" = {
    source = jsonFormat.generate "zed-user-settings" mergedSettings;
    onChange = ''
      cp $HOME/.config/zed/settings.json $HOME/.config/zed/settings.json.tmp
      mv $HOME/.config/zed/settings.json.tmp $HOME/.config/zed/settings.json
    '';
  };

  programs.zed-editor = {
    enable = true;
    package = zed-editor;

    extraPackages = with pkgs; [
      nixd
      nil
    ];

    extensions = [
      "nix"
      "kdl"
      "justfile"
      "log"
      "html"
      "vue"
      "biome"
    ];

    userSettings = {
      features.inline_completion_provider = "zed";
      collaboration_panel.button = false;

      ui_font_family = "JetBrainsMono Nerd Font";
      buffer_font_family = "JetBrainsMono Nerd Font";
      buffer_font_size = 14;

      languages = {
        Nix.formatter.external = {
          command = "nixfmt";
          arguments = [
            "--quiet"
            "--"
          ];
        };
      };

      formatter.language_server.name = "biome";
      code_actions_on_format = {
        "source.fixAll.biome" = true;
        "source.organizeImports.biome" = true;
      };

      theme = {
        mode = "dark";
        dark = "Ayu Dark";
        light = "Gruvbox Light Hard";
      };
    };
  };
}
