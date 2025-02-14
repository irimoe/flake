{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    package = pkgs.zed-editor;

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
