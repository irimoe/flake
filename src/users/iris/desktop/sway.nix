{
  pkgs,
  ...
}:

let
  videoPath = "/home/iris/Videos/bg.webm";
  super = "Mod4";

  zed-editor = pkgs.callPackage ../../../packages/derivations/zed-editor.nix { };

  term = "${pkgs.foot}/bin/foot";
  menu = "${pkgs.fuzzel}/bin/fuzzel";
  browser = "${pkgs.firefox}/bin/firefox";
  editor = "${zed-editor}/bin/zed-editor";
  discord = "${pkgs.discord}/bin/discord";
  thunderbird = "${pkgs.thunderbird}/bin/thunderbird";
  youtube-music = "${pkgs.youtube-music}/bin/youtube-music";
  keepassxc = "${pkgs.keepassxc}/bin/keepassxc";

  jq = "${pkgs.jq}/bin/jq";

  swaymsg = "${pkgs.sway}/bin/swaymsg";
  swayosd = "${pkgs.swayosd}/bin/swayosd-client";
  swayosd-server = "${pkgs.swayosd}/bin/swayosd-server";
  swaync = "${pkgs.swaynotificationcenter}/bin/swaync";
  swaync-client = "${pkgs.swaynotificationcenter}/bin/swaync-client";

  get-layout = "${swaymsg} -t get_inputs | ${jq} 'map(select(has(\"xkb_active_layout_name\")))[0].xkb_active_layout_name'";

  direction_keys = {
    left = "q";
    right = "w";
    up = "a";
    down = "s";
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
    builtins.map (workspace: "bindsym ${super}+${workspace} workspace number ${workspace}") (
      builtins.attrNames workspaces
    )
    ++ builtins.map (
      workspace: "bindsym ${super}+Shift+${workspace} move container to workspace number ${workspace}"
    ) (builtins.attrNames workspaces)
  );

  autostartApps = ''
    exec ${swaync}
    exec ${swayosd-server}
    exec mpvpaper '*' "${videoPath}" -o "--loop --no-audio --no-input"

    exec waybar
    exec swaymsg "workspace 1; exec ${editor}"; assign [class="dev.zed.Zed"] 1
    exec swaymsg "workspace 1; exec ${term}"; assign [class="foot"] 1
    exec swaymsg "workspace 5; exec ${thunderbird}"; assign [class="${thunderbird}"] 5
    exec swaymsg "workspace 5; exec ${youtube-music}"; assign [class="com.github.th_ch.youtube_music"] 5
    exec swaymsg "workspace 9; exec ${keepassxc}"; assign [class="org.keepassxc.KeePassXC"] 9

    exec swaymsg "workspace 2; exec ${browser}"; assign [class="firefox"] 2
    exec swaymsg "workspace 2; exec ${discord}"; assign [class="discord"] 2

    exec swaymsg "workspace 9;"
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
    for_window [app_id="swaymux"] floating enable
  '';

  keybindings = ''
    bindsym ${super}+t exec ${term}
    bindsym ${super}+Shift+e kill
    bindsym ${super}+d exec ${menu}
    floating_modifier ${super} normal
    bindsym ${super}+Shift+c reload; exec killall waybar && waybar && swaync-client -rs && swaync-client --reload-config
    bindsym ${super}+Ctrl+Shift+e exec swaynag -t warning -m 'Exit' -B 'Yes' 'swaymsg exit'

    bindsym ${super}+${direction_keys.left} focus left
    bindsym ${super}+${direction_keys.right} focus right
    bindsym ${super}+${direction_keys.up} focus up
    bindsym ${super}+${direction_keys.down} focus down

    bindsym ${super}+${direction_keys.left}+Shift move left
    bindsym ${super}+${direction_keys.right}+Shift move right
    bindsym ${super}+${direction_keys.up}+Shift move up
    bindsym ${super}+${direction_keys.down}+Shift move down

    bindsym ${super}+b splith
    bindsym ${super}+Ctrl+Shift+b splitv
    bindsym ${super}+Ctrl+Shift+s layout stacking
    bindsym ${super}+Ctrl+Shift+w layout tabbed
    bindsym ${super}+Alt+e layout toggle split

    bindsym ${super}+f fullscreen
    bindsym ${super}+Shift+space floating toggle
    bindsym ${super}+space focus mode_toggle
    # bindsym ${super}+a focus parent

    # bindsym ${super}+Shift+Tab move scratchpad
    # bindsym ${super}+Tab scratchpad show

    bindsym ${super}+grave exec swaymux
    bindsym ${super}+Tab exec ${swaync-client} -t -sw

    mode "resize" {
        bindsym ${direction_keys.left} resize shrink width 10px
        bindsym ${direction_keys.down} resize grow height 10px
        bindsym ${direction_keys.up} resize shrink height 10px
        bindsym ${direction_keys.right} resize grow width 10px
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }
    bindsym ${super}+Shift+r mode "resize"

    bindsym --locked XF86AudioRaiseVolume exec ${swayosd} --output-volume raise 5
    bindsym --locked XF86AudioLowerVolume exec ${swayosd} --output-volume lower 5
    bindsym --locked XF86AudioMicMute exec ${swayosd} --output-volume mute-toggle
    bindsym --locked XF86MonBrightnessUp exec ${swayosd} --brightness raise
    bindsym --locked XF86MonBrightnessDown exec ${swayosd} --brightness lower

    bindsym --locked XF86AudioPlay exec media-things --play-pause
    bindsym --locked XF86AudioNext exec media-things --next
    bindsym --locked XF86AudioPrev exec media-things --previous
    bindsym --locked XF86AudioStop exec media-things --stop

    bindsym ${super}+Shift+d exec screenshot
    bindsym ${super}+Backspace input "6940:7076:Corsair_CORSAIR_K55_RGB_PRO_Gaming_Keyboard" xkb_switch_layout next; exec ${swayosd} --custom-message "Layout changed to $(${get-layout})"
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
    layer_effects "swayosd" blur enable; blur_ignore_transparent enable
    layer_effects "astral" blur enable; blur_ignore_transparent enable
  '';

  inputConfig = ''
    input type:keyboard {
        xkb_layout gb,gb
        xkb_variant ,dvorak
        xkb_options caps:ctrl_modifier,
    }
  '';

in
{

  home.packages = [
    pkgs.swayosd
    pkgs.swaymux
    pkgs.swaynotificationcenter
    pkgs.swaylock
    pkgs.swaylock-fancy
    pkgs.i3lock-color # dep of swaylock-fancy
    pkgs.wmctrl
  ];

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;
    wrapperFeatures.gtk = true;

    checkConfig = false; # https://github.com/nix-community/home-manager/issues/5311
    config = null; # clear default config

    extraConfig =
      inputConfig
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
