{ pkgs, ... }:

let

  swayosd = "${pkgs.swayosd}/bin/swayosd-client";
  playerctl = "${pkgs.playerctl}/bin/playerctl";
  mpvpaper = "${pkgs.mpvpaper}/bin/mpvpaper";

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
    function screenshot {
        path="/home/iris/Pictures/Screenshots/$(date +%Y-%m-%d-%H-%M-%S).png"
        grim -c -g "$(slurp)" "$path" && wl-copy < "$path";
        killall wayfreeze

        result=$(notify-send "screenshot saved!" "$path" \
            --action=open="open in imv" \
                --action=browser="open in firefox" \
            )

            echo $result

            if [ "$result" == "open" ]; then
                imv "$path" -w "screenshot" &
            elif [ "$result" == "browser" ]; then
                firefox "$path"
            fi
    }

    wayfreeze &
    screenshot $PID &

  '';

  wallpaper = pkgs.writeShellScriptBin "wallpaper-cycle" ''
    #!/usr/bin/env bash
    WALLPAPERS=$(ls /home/iris/Videos/Wallpapers)
    RND=$(shuf -n 1 <<< "$WALLPAPERS")

    pkill -f "mpvpaper"
    ${mpvpaper} '*' "/home/iris/Videos/Wallpapers/$RND" -o "--loop --no-audio --no-input"
    ${swayosd} --custom-icon "image-x-generic" --custom-message "Wallpaper changed to '$RND'"
  '';

  gituser = pkgs.writeShellScriptBin "gituser" ''
    #!/usr/bin/env bash
    if [ "$1" == "willow" ]; then
        git config user.email "willow@iri.moe"
        git config user.name "willow"
    elif [ "$1" == "iris" ]; then
        git config user.email "iri@iri.moe"
        git config user.name "iris"
    else
        echo "invalid user"
        exit 1
    fi
  '';

in
{
  home.packages = [
    media-things
    screenshot
    wallpaper
    gituser
  ];
}
