{ lib, pkgs }:
{
  theme = {
    mode = "light";
    ctp = {
      light = "latte";
      dark = "mocha";
      flavor = "rosewater";
      mkFullName = name: "Catppuccin ${lib.toUpper (lib.substring 0 1 name)}${lib.substring 1 (-1) name}";
      getCurrent = config: config.theme.ctp.${config.theme.mode};
      footColours = {
        latte = {
          foreground = "4c4f69";
          background = "eff1f5";

          regular0 = "5c5f77";
          regular1 = "d20f39";
          regular2 = "40a02b";
          regular3 = "df8e1d";
          regular4 = "1e66f5";
          regular5 = "ea76cb";
          regular6 = "179299";
          regular7 = "acb0be";

          bright0 = "6c6f85";
          bright1 = "d20f39";
          bright2 = "40a02b";
          bright3 = "df8e1d";
          bright4 = "1e66f5";
          bright5 = "ea76cb";
          bright6 = "179299";
          bright7 = "bcc0cc";

          "16" = "fe640b";
          "17" = "dc8a78";

          selection-foreground = "4c4f69";
          selection-background = "ccced7";

          search-box-no-match = "dce0e8 d20f39";
          search-box-match = "4c4f69 ccd0da";

          jump-labels = "dce0e8 fe640b";
          urls = "1e66f5";
        };

        frappe = {
          foreground = "c6d0f5";
          background = "303446";

          regular0 = "51576d";
          regular1 = "e78284";
          regular2 = "a6d189";
          regular3 = "e5c890";
          regular4 = "8caaee";
          regular5 = "f4b8e4";
          regular6 = "81c8be";
          regular7 = "b5bfe2";

          bright0 = "626880";
          bright1 = "e78284";
          bright2 = "a6d189";
          bright3 = "e5c890";
          bright4 = "8caaee";
          bright5 = "f4b8e4";
          bright6 = "81c8be";
          bright7 = "a5adce";

          "16" = "ef9f76";
          "17" = "f2d5cf";

          selection-foreground = "c6d0f5";
          selection-background = "4f5369";

          search-box-no-match = "232634 e78284";
          search-box-match = "c6d0f5 414559";

          jump-labels = "232634 ef9f76";
          urls = "8caaee";
        };

        macchiato = {
          foreground = "cad3f5";
          background = "24273a";

          regular0 = "494d64";
          regular1 = "ed8796";
          regular2 = "a6da95";
          regular3 = "eed49f";
          regular4 = "8aadf4";
          regular5 = "f5bde6";
          regular6 = "8bd5ca";
          regular7 = "b8c0e0";

          bright0 = "5b6078";
          bright1 = "ed8796";
          bright2 = "a6da95";
          bright3 = "eed49f";
          bright4 = "8aadf4";
          bright5 = "f5bde6";
          bright6 = "8bd5ca";
          bright7 = "a5adcb";

          "16" = "f5a97f";
          "17" = "f4dbd6";

          selection-foreground = "cad3f5";
          selection-background = "454a5f";

          search-box-no-match = "181926 ed8796";
          search-box-match = "cad3f5 363a4f";

          jump-labels = "181926 f5a97f";
          urls = "8aadf4";
        };

        mocha = {
          foreground = "cdd6f4";
          background = "1e1e2e";

          regular0 = "45475a";
          regular1 = "f38ba8";
          regular2 = "a6e3a1";
          regular3 = "f9e2af";
          regular4 = "89b4fa";
          regular5 = "f5c2e7";
          regular6 = "94e2d5";
          regular7 = "bac2de";

          bright0 = "585b70";
          bright1 = "f38ba8";
          bright2 = "a6e3a1";
          bright3 = "f9e2af";
          bright4 = "89b4fa";
          bright5 = "f5c2e7";
          bright6 = "94e2d5";
          bright7 = "a6adc8";

          "16" = "fab387";
          "17" = "f5e0dc";

          selection-foreground = "cdd6f4";
          selection-background = "414356";

          search-box-no-match = "11111b f38ba8";
          search-box-match = "cdd6f4 313244";

          jump-labels = "11111b fab387";
          urls = "89b4fa";
        };
      };
      colours = {
        latte = {
          rosewater = "#dc8a78";
          flamingo = "#dd7878";
          pink = "#ea76cb";
          mauve = "#8839ef";
          red = "#d20f39";
          maroon = "#e64553";
          peach = "#fe640b";
          yellow = "#df8e1d";
          green = "#40a02b";
          teal = "#179299";
          sky = "#04a5e5";
          sapphire = "#209fb5";
          blue = "#1e66f5";
          lavender = "#7287fd";
          text = "#4c4f69";
          subtext1 = "#5c5f77";
          subtext0 = "#6c6f85";
          overlay2 = "#7c7f93";
          overlay1 = "#8c8fa1";
          overlay0 = "#9ca0b0";
          surface2 = "#acb0be";
          surface1 = "#bcc0cc";
          surface0 = "#ccd0da";
          base = "#eff1f5";
          mantle = "#e6e9ef";
          crust = "#dce0e8";
        };
        frappe = {
          rosewater = "#f2d5cf";
          flamingo = "#eebebe";
          pink = "#f4b8e4";
          mauve = "#ca9ee6";
          red = "#e78284";
          maroon = "#ea999c";
          peach = "#ef9f76";
          yellow = "#e5c890";
          green = "#a6d189";
          teal = "#81c8be";
          sky = "#99d1db";
          sapphire = "#85c1dc";
          blue = "#8caaee";
          lavender = "#babbf1";
          text = "#c6d0f5";
          subtext1 = "#b5bfe2";
          subtext0 = "#a5adce";
          overlay2 = "#949cbb";
          overlay1 = "#838ba7";
          overlay0 = "#737994";
          surface2 = "#626880";
          surface1 = "#51576d";
          surface0 = "#414559";
          base = "#303446";
          mantle = "#292c3c";
          crust = "#232634";
        };
        macchiato = {
          rosewater = "#f4dbd6";
          flamingo = "#f0c6c6";
          pink = "#f5bde6";
          mauve = "#c6a0f6";
          red = "#ed8796";
          maroon = "#ee99a0";
          peach = "#f5a97f";
          yellow = "#eed49f";
          green = "#a6da95";
          teal = "#8bd5ca";
          sky = "#91d7e3";
          sapphire = "#7dc4e4";
          blue = "#8aadf4";
          lavender = "#b7bdf8";
          text = "#cad3f5";
          subtext1 = "#b8c0e0";
          subtext0 = "#a5adcb";
          overlay2 = "#939ab7";
          overlay1 = "#8087a2";
          overlay0 = "#6e738d";
          surface2 = "#5b6078";
          surface1 = "#494d64";
          surface0 = "#363a4f";
          base = "#24273a";
          mantle = "#1e2030";
          crust = "#181926";
        };
        mocha = {
          rosewater = "#f5e0dc";
          flamingo = "#f2cdcd";
          pink = "#f5c2e7";
          mauve = "#cba6f7";
          red = "#f38ba8";
          maroon = "#eba0ac";
          peach = "#fab387";
          yellow = "#f9e2af";
          green = "#a6e3a1";
          teal = "#94e2d5";
          sky = "#89dceb";
          sapphire = "#74c7ec";
          blue = "#89b4fa";
          lavender = "#b4befe";
          text = "#cdd6f4";
          subtext1 = "#bac2de";
          subtext0 = "#a6adc8";
          overlay2 = "#9399b2";
          overlay1 = "#7f849c";
          overlay0 = "#6c7086";
          surface2 = "#585b70";
          surface1 = "#45475a";
          surface0 = "#313244";
          base = "#1e1e2e";
          mantle = "#181825";
          crust = "#11111b";
        };
      };
    };
  };

  wallpapers = {
    directory = "/home/iris/Videos/Wallpapers";
    history = {
      file = "/home/iris/.wallpaper-history";
      max = 10;
    };
  };

  terminal = {
    font = {
      family = "JetBrainsMono Nerd Font";
      size = 14;
    };
  };
}
