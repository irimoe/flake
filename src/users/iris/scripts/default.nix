{ pkgs, ... }:

let

  swayosd = "${pkgs.swayosd}/bin/swayosd-client";
  grim = "${pkgs.grim}/bin/grim";
  slurp = "${pkgs.slurp}/bin/slurp";
  playerctl = "${pkgs.playerctl}/bin/playerctl";

  media-things = pkgs.writeShellScriptBin "media-things" ''
    #!/usr/bin/env bash

    name=$(playerctl metadata --format "{{xesam:title}}")
    icon="audio-x-generic"
    isPlaying=$(playerctl status)

    if [ "$1" == "--play-pause" ]; then
        if [ "$isPlaying" == "Playing" ]; then
          message="Playing '$name'"
          icon="media-playback-start"
        else
          message="Paused '$name'"
          icon="media-playback-pause"
        fi

        ${playerctl} play-pause
        ${swayosd} --custom-icon "$icon" --custom-message "$message"
    elif [ "$1" == "--next" ]; then
        ${playerctl} next
        ${swayosd} --custom-icon "media-skip-forward" --custom-message "Skipped '$name'"
    elif [ "$1" == "--previous" ]; then
        ${playerctl} previous
        ${swayosd} --custom-icon "media-skip-backward" --custom-message "Skipped '$name'"
    elif [ "$1" == "--stop" ]; then
      ${playerctl} stop
      ${swayosd} --custom-icon "media-playback-stop" --custom-message "Stopped '$name'"
    else
      echo "Invalid argument"
      exit 1
    fi
  '';

  screenshot = pkgs.writeShellScriptBin "screenshot" ''
    #!/usr/bin/env bash
    # ~/Pictures/Screenshots/
    path="/home/iris/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png"
    ${grim} -g "$(${slurp})" "$path" && wl-copy < "$path" && ${swayosd} --custom-message "Screenshot taken"
  '';

in
{
  home.packages = [
    media-things
    screenshot
  ];
}
