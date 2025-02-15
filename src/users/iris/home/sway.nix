{
  pkgs,
  ...
}:

let
  videoPath = "/home/iris/Videos/bg.webm";
  modifier = "Mod4";

  zed-editor = pkgs.callPackage ../programs/zed-editor.nix { };

  term = "${pkgs.foot}/bin/foot";
  menu = "${pkgs.fuzzel}/bin/fuzzel";
  browser = "${pkgs.firefox}/bin/firefox";
  editor = "${zed-editor}/bin/zed-editor";
  discord = "${pkgs.discord}/bin/discord";
  thunderbird = "${pkgs.thunderbird}/bin/thunderbird";
  youtube-music = "${pkgs.youtube-music}/bin/youtube-music";
  keepassxc = "${pkgs.keepassxc}/bin/keepassxc";

  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";

  direction_keys = {
    left = "Left";
    right = "Right";
    up = "Up";
    down = "Down";
  };

  workspaces = {
    "1" = "DP-1";
    "2" = "HDMI-A-1";
    "3" = "DP-1";
    "4" = "HDMI-A-1";
    "5" = "DP-1";
    "6" = "HDMI-A-1";
    "7" = "DP-1";
    "8" = "HDMI-A-1";
    "9" = "DP-1";
  };

  workspaceBindings = builtins.concatStringsSep "\n" (
    builtins.map (workspace: "bindsym ${modifier}+${workspace} workspace number ${workspace}") (
      builtins.attrNames workspaces
    )
    ++ builtins.map (
      workspace: "bindsym ${modifier}+Shift+${workspace} move container to workspace number ${workspace}"
    ) (builtins.attrNames workspaces)
  );

  autostartApps = ''
    exec swayidle -w timeout 300 '~/.config/scripts/lock' &
    exec waybar
    exec swaymsg "workspace 1; exec ${editor}"; assign [class="${editor}"] 1
    exec swaymsg "workspace 1; exec ${term}"; assign [class="${term}"] 1
    exec swaymsg "workspace 5; exec ${thunderbird}"; assign [class="${thunderbird}"] 5
    exec swaymsg "workspace 5; exec ${youtube-music}"; assign [class="${youtube-music}"] 5
    exec swaymsg "workspace 9; exec ${keepassxc}"; assign [class="${keepassxc}"] 9
    exec swaymsg "workspace 2; exec ${browser}"; assign [class="${browser}"] 2
    exec swaymsg "workspace 2; exec ${discord}"; assign [class="${discord}"] 2
    exec swaymsg "workspace 9;"
    exec swaync
    exec mpvpaper '*' "${videoPath}" -o "--loop --no-audio --no-input"
  '';

  floatingRules = ''
    for_window [window_role = "pop-up"] floating enable
    for_window [window_role = "bubble"] floating enable
    for_window [window_role = "dialog"] floating enable
    for_window [window_type = "dialog"] floating enable
    for_window [window_role = "task_dialog"] floating enable
    for_window [window_type = "menu"] floating enable
    for_window [app_id = "floating"] floating enable
    for_window [app_id = "floating_update"] floating enable, resize set width 1000px height 600px
    for_window [class = "(?i)pinentry"] floating enable
    for_window [title = "Administrator privileges required"] floating enable
    for_window [title = "Open files"] floating enable, resize set width 768px height 768px
    for_window [title = "About Mozilla Firefox"] floating enable
    for_window [window_role = "About"] floating enable
    for_window [app_id="firefox" title="Library"] floating enable
    for_window [app_id="librewolf" title="Library"] floating enable
    for_window [title = "Firefox - Sharing Indicator"] kill
    for_window [title = "Firefox — Sharing Indicator"] kill
    for_window [title = "librewolf - Sharing Indicator"] kill
    for_window [title = "librewolf — Sharing Indicator"] kill
  '';

  keybindings = ''
    bindsym ${modifier}+t exec ${term}
    bindsym ${modifier}+Shift+q kill
    bindsym ${modifier}+d exec ${menu}
    floating_modifier ${modifier} normal
    bindsym ${modifier}+Shift+c reload; exec killall waybar && waybar && swaync-client -rs && swaync-client --reload-config
    bindsym ${modifier}+Shift+e exec swaynag -t warning -m 'Exit' -B 'Yes' 'swaymsg exit'

    bindsym ${modifier}+${direction_keys.left} focus left
    bindsym ${modifier}+${direction_keys.down} focus down
    bindsym ${modifier}+${direction_keys.up} focus up
    bindsym ${modifier}+${direction_keys.right} focus right

    bindsym ${modifier}+Shift+h move left
    bindsym ${modifier}+Shift+j move down
    bindsym ${modifier}+Shift+k move up
    bindsym ${modifier}+Shift+l move right

    bindsym ${modifier}+b splith
    bindsym ${modifier}+v splitv
    bindsym ${modifier}+s layout stacking
    bindsym ${modifier}+w layout tabbed
    bindsym ${modifier}+e layout toggle split
    bindsym ${modifier}+f fullscreen
    bindsym ${modifier}+Shift+space floating toggle
    bindsym ${modifier}+space focus mode_toggle
    bindsym ${modifier}+a focus parentc

    bindsym ${modifier}+Shift+minus move scratchpad
    bindsym ${modifier}+minus scratchpad show

    mode "resize" {
        bindsym ${direction_keys.left} resize shrink width 10px
        bindsym ${direction_keys.down} resize grow height 10px
        bindsym ${direction_keys.up} resize shrink height 10px
        bindsym ${direction_keys.right} resize grow width 10px
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }
    bindsym ${modifier}+Shift+r mode "resize"

    bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume @DEFAULT_SINK@ +5% && pactl set-sink-mute @DEFAULT_SINK@ 0
    bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume @DEFAULT_SINK@ -5% && pactl set-sink-mute @DEFAULT_SINK@ 0
    bindsym --locked XF86AudioMute exec pactl set-sink-mute @DEFAULT_SINK@ toggle
    bindsym --locked XF86AudioMicMute exec pactl set-source-mute @DEFAULT_SOURCE@ toggle
    bindsym --locked XF86MonBrightnessUp exec brightnessctl set +10%
    bindsym --locked XF86MonBrightnessDown exec brightnessctl set 10%-

    bindsym --locked XF86AudioPlay exec playerctl play-pause
    bindsym --locked XF86AudioNext exec playerctl next
    bindsym --locked XF86AudioPrev exec playerctl previous
    bindsym --locked XF86AudioStop exec playerctl stop

    bindsym ${modifier}+Shift+s exec ${grim} -g "$(${slurp})" ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png && wl-copy < ~/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png
    bindsym ${modifier}+Shift+x exec killall waybar && waybar
    bindsym ${modifier}+Backspace input "6940:7076:Corsair_CORSAIR_K55_RGB_PRO_Gaming_Keyboard" xkb_switch_layout next
    bindsym ${modifier}+grave exec swaync-client -t
  '';

  visuals = ''
    gaps inner 4
    gaps outer 2
    smart_gaps on

    default_border none
    default_floating_border none

    corner_radius 8
    blur enable
    blur_noise 0.15
    blur_radius 8
    default_dim_inactive 0.2

    default_border pixel 1
    client.focused_inactive #323232 #323232 #ffffff #323232
    client.urgent #ff0000 #ff0000 #ffffff #ff0000
    client.placeholder #000000 #000000 #ffffff #000000

    client.background #282828

    shadows enable
    shadow_color #000000DD
    shadow_inactive_color #00000000

    # output * bg #0a0a0a solid_color

    layer_effects "swaync-notification-window" blur enable; blur_ignore_transparent enable
    layer_effects "swaync-control-center" blur enable; blur_ignore_transparent enable
  '';

  inputConfig = ''
    input type:keyboard {
        xkb_layout gb,gb
        xkb_variant ,dvorak
        xkb_options caps:ctrl_modifier,
    }
  '';

  barConfig = ''
    bar {
        position bottom
        status_command while date +'%Y-%m-%d %X'; do sleep 1; done

        colors {
            statusline #ffffff
            background #323232
            inactive_workspace #32323200 #32323200 #5c5c5c
        }
    }
  '';

in
{

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

    checkConfig = false; # https://github.com/nix-community/home-manager/issues/5311
    config = null; # clear default config

    extraConfig =
      inputConfig
      + "\n"
      + barConfig
      + "\n"
      + visuals
      + "\n"
      + keybindings
      + "\n"
      + autostartApps
      + "\n"
      + floatingRules
      + "\n"
      + workspaceBindings
      + "\n"
      + builtins.concatStringsSep "\n" (
        builtins.map (workspace: "workspace ${workspace} output ${workspaces.${workspace}}") (
          builtins.attrNames workspaces
        )
      );
  };
}
