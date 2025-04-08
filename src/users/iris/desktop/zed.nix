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

    language_models.openai = {
      version = "1";
      api_url = "https://openrouter.ai/api/v1";
      available_models = [
        {
          name = "deepseek/deepseek-r1:free";
          display_name = "DeepSeek R1";
          max_tokens = 163840;
          max_output_tokens = 4096;
          max_completion_tokens = 4096;
        }
        {
          name = "deepseek/deepseek-chat:free";
          display_name = "DeepSeek V3";
          max_tokens = 32768;
          max_output_tokens = 32768;
          max_completion_tokens = 32768;
        }
        {
          name = "google/gemini-exp-1206:free";
          display_name = "Gemini Exp 1206";
          max_tokens = 131072;
          max_output_tokens = 128000;
          max_completion_tokens = 128000;
        }
      ];
    };

    theme = {
      mode = "dark";
      dark = "Catppuccin Mocha";
      light = "Catppuccin Latte";
    };
  };

  copyScript = pkgs.writeShellScript "copy-zed-settings" ''
    SETTINGS_FILE="$HOME/.config/zed/settings.json"
    LOG_FILE="$HOME/.config/zed/log"

    current_date=$(date)
    pretty_date=$(date +"%Y-%m-%d %H:%M:%S")
    backup_file="$HOME/.config/zed/bak/settings.$(pretty_date).json"

    log_content=$(cat "$LOG_FILE" 2>/dev/null || echo "")

    mkdir -p $HOME/.config/zed/bak
    rm $LOG_FILE

    full_line="    ran at $current_date    "
    separator=$(echo "$full_line" | tr 'a-zA-Z0-9: ' '=')

    echo "|$separator|" >> $LOG_FILE
    echo "|$full_line|" >> $LOG_FILE
    echo "|$separator|" >> $LOG_FILE

    echo "|      prep : mkdir -p $HOME/.config/zed/bak" >> $LOG_FILE
    echo "|      prep : rm $LOG_FILE" >> $LOG_FILE

    echo "|  settings : $SETTINGS_FILE" >> $LOG_FILE
    echo "|       log : $LOG_FILE" >> $LOG_FILE

    echo "|       cmd : mv -f $SETTINGS_FILE $backup_file" >> $LOG_FILE
    mv -f "$SETTINGS_FILE" "$backup_file"

    echo "|       cmd : cp ${pkgs.writeText "zed-settings.json" zedSettings} $SETTINGS_FILE" >> $LOG_FILE
    echo "|       cmd : chmod u+w $SETTINGS_FILE" >> $LOG_FILE
    cp ${pkgs.writeText "zed-settings.json" zedSettings} "$SETTINGS_FILE"
    chmod u+w "$SETTINGS_FILE"

    echo "|       cmd : echo 'Settings copied successfully.'" >> $LOG_FILE

    if [ -n "$log_content" ]; then
        echo "" >> $LOG_FILE
        echo "$log_content" >> $LOG_FILE
    fi
  '';
in
{
  home.activation.copyZedSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${copyScript}
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
    ];

  };
}
