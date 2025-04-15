{ pkgs, ... }:

let

  swayosd = "${pkgs.swayosd}/bin/swayosd-client";
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
    WALLPAPER_DIR="/home/iris/Videos/Wallpapers"
    HISTORY_FILE="/home/iris/.wallpaper-history"
    MAX_HISTORY=10

    touch "$HISTORY_FILE"

    WALLPAPERS=$(ls "$WALLPAPER_DIR")
    AVAILABLE_WALLPAPERS=$(grep -vxFf "$HISTORY_FILE" <<< "$WALLPAPERS")

    if [[ -z "$AVAILABLE_WALLPAPERS" ]]; then
        tail -n 1 "$HISTORY_FILE" > "$HISTORY_FILE.tmp"
        mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"
        AVAILABLE_WALLPAPERS=$(grep -vxFf "$HISTORY_FILE" <<< "$WALLPAPERS")
    fi

    RND=$(shuf -n 1 <<< "$AVAILABLE_WALLPAPERS")
    echo $RND
    pkill -f "mpvpaper";

    echo "$RND" >> "$HISTORY_FILE"
    tail -n "$MAX_HISTORY" "$HISTORY_FILE" > "$HISTORY_FILE.tmp"
    mv "$HISTORY_FILE.tmp" "$HISTORY_FILE"

    if [[ "$RND" == *.webm ]]; then
        pkill -f "mpvpaper"; pkill -f "swww";
        mpvpaper '*' "$WALLPAPER_DIR/$RND" -o "--loop --no-audio --no-input" >/dev/null 2>&1 &
    else
        if [[ ! $(pgrep -x "swww-daemon") ]]; then
            swww-daemon &
            sleep 0.5
        fi
        echo $(pgrep -x "swww-daemon")
        swww img "$WALLPAPER_DIR/$RND" -t grow
    fi
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
