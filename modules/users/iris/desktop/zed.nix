{
  pkgs,
  lib,
  globalConfig,
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
      api_url = "https://llm.chutes.ai/v1";
      available_models = [
        {
          name = "deepseek-ai/DeepSeek-V3-0324";
          display_name = "deepseek v3";
          max_tokens = 128000;
          max_output_tokens = 8192;
          max_completion_tokens = 8192;
        }
        {
          name = "chutesai/Llama-4-Maverick-17B-128E-Instruct-FP8";
          display_name = "llama 4 maverick";
          max_tokens = 1000000;
          max_output_tokens = 8192;
          max_completion_tokens = 8192;
        }
        {
          name = "chutesai/Llama-4-Scout-17B-16E-Instruct";
          display_name = "llama 4 scout";
          max_tokens = 10000000;
          max_output_tokens = 8192;
          max_completion_tokens = 8192;
        }
        {
          name = "deepseek-ai/DeepSeek-R1";
          display_name = "deepseek r1";
          max_tokens = 128000;
          max_output_tokens = 32768;
          max_completion_tokens = 8192;
        }
        {
          name = "deepseek-ai/DeepSeek-R1-Zero";
          display_name = "deepseek r1 zero";
          max_tokens = 128000;
          max_output_tokens = 8192;
          max_completion_tokens = 8192;
        }
        {
          name = "moonshotai/Kimi-VL-A3B-Thinking";
          display_name = "kimi vl a38";
          max_tokens = 128000;
          max_output_tokens = 8192;
          max_completion_tokens = 8192;
        }
      ];
    };

    theme = {
      mode = globalConfig.theme.mode;
      dark = globalConfig.theme.ctp.mkFullName globalConfig.theme.ctp.dark;
      light = globalConfig.theme.ctp.mkFullName globalConfig.theme.ctp.light;
    };
  };

  copyScript = pkgs.writeShellScript "copy-zed-settings" ''
    SETTINGS_FILE="$HOME/.config/zed/settings.json"
    LOG_FILE="$HOME/.config/zed/log"

    current_date=$(date)
    pretty_date=$(date +"%Y-%m-%d %H:%M:%S")
    backup_file="$HOME/.config/zed/.bak/settings.$pretty_date.json"
    latest_file="$HOME/.config/zed/.bak/settings.latest.json"

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
    cp "$backup_file" "$latest_file"

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
