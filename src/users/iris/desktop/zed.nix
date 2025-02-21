{
  pkgs,
  lib,
  ...
}:
let
  zedSettings = builtins.toJSON {
    collaboration_panel.button = false;
    auto_update = false;

    ui_font_family = "JetBrainsMono Nerd Font";
    buffer_font_family = "JetBrainsMono Nerd Font";
    buffer_font_size = 14;

    features.edit_prediction_provider = "zed";

    languages = {
      Nix.formatter.external = {
        command = "nixfmt";
        arguments = [
          "--quiet"
          "--"
        ];
      };
    };

    lsp = {
      nix = {
        binary = {
          path_lookup = true;
        };
      };

      "rust-analyzer" = {
        binary = {
          path = "${pkgs.nix}/bin/nix";
          arguments = [
            "develop"
            "--extra-experimental-features"
            "nix-command"
            "--extra-experimental-features"
            "flakes"
            "--command"
            "rust-analyzer"
          ];
        };
        settings = {

          server = {
            extraEnv = {
              RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
            };
          };
          diagnostics = {
            enable = true;
            styleLints.enable = true;
          };
          checkOnSave = true;
          check = {
            command = "clippy";
            features = "all";
          };
          cargo = {
            buildScripts.enable = true;
            features = "all";
          };
          inlayHints = {
            bindingModeHints.enable = true;
            closureStyle = "rust_analyzer";
            closureReturnTypeHints.enable = "always";
            discriminantHints.enable = "always";
            expressionAdjustmentHints.enable = "always";
            implicitDrops.enable = true;
            lifetimeElisionHints.enable = "always";
            rangeExclusiveHints.enable = true;
          };
          procMacro.enable = true;
          rustc.source = "discover";

          files = {
            excludeDirs = [
              ".cargo"
              ".direnv"
              ".git"
              "node_modules"
              "target"
            ];
          };
        };
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

  copyScript = pkgs.writeShellScript "copy-zed-settings" ''
    mkdir -p $HOME/.config/zed
    settings_file="$HOME/.config/zed/settings.json"

    if [ -L "$settings_file" ] || [ ! -f "$settings_file" ]; then
        mv -f "$settings_file" "$settings_file.$(date +%s)"
    fi

    cp ${pkgs.writeText "zed-settings.json" zedSettings} "$settings_file"
    chmod u+w "$settings_file"
  '';
in
{
  home.activation.copyZedSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ${copyScript}
  '';

  programs.zed-editor = {
    enable = false;
    package = pkgs.derivations.zed-editor;

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

    installRemoteServer = true;
  };
}
