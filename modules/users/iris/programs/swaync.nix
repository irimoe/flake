{
  globalConfig,
  lib,
  pkgs,
  ...
}:
let
  colours = globalConfig.theme.ctp.colours.${globalConfig.theme.ctp.getCurrent globalConfig};
  styleVariableString = lib.concatStringsSep "\n" (
    lib.mapAttrsToList (name: value: "@define-color ${name} ${value};") colours
  );

  styleMainString = "
    * {
        all: unset;
    }

    .control-center {
        background: alpha(@crust, 0.8);
        border: 1px solid @subtext0;
        margin: 1rem;
        padding: 0.5rem;
        border-radius: 0.5rem;
    }

    /* ===========================================
        Reusable
        =========================================== */

    /* buttons */

    button,
    .notification-action,
    .frame .linked button {
        background: @crust;
        border: 1px solid @mantle;
        color: @text;
        border-radius: 500rem;
        padding: 0.25rem 1rem;
        transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    button:hover {
        background: @mantle;
    }

    button:active {
        background: shade(@mantle, 1.2);
        border: 1px solid shade(@surface2, 1.2);
    }

    button:checked {
        background: @mantle;
        border: 1px solid @surface2;
        color: @text;
        border-radius: 500rem;
        padding: 0.25rem 1rem;
        transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    }

    button:checked:hover {
        background: @surface1;
    }

    button:checked:active {
        background: shade(@surface1, 1.2);
        border: 1px solid shade(@surface2, 1.2);
    }

    /* switch */

    switch {
        background: @crust;
        border: 1px solid @mantle;
        border-radius: 500rem;
        padding: 0.1rem;
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }

    switch:hover {
        background: @mantle;
    }

    switch:active {
        background: shade(@mantle, 1.2);
        border: 1px solid shade(@surface2, 1.2);
    }

    switch:checked {
        border: 1px solid shade(@surface2, 0.8);
    }

    switch slider {
        background: @mauve;
        border-radius: 500rem;
        padding: 0.1rem;
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }

    switch slider:hover {
        background: alpha(@mauve, 0.8);
    }

    switch slider:active {
        background: alpha(shade(@mauve, 1), 0.8);
    }

    /* ===========================================
        Title
        =========================================== */

    .widget-title,
    .widget-dnd {
        margin-bottom: 0.5rem;
        padding-bottom: 0.5rem;
    }

    .widget-title > label {
        font-size: 1.25rem;
        font-weight: 900;
        color: @mauve;
    }

    button.control-center-clear-all {
        border: 1px solid @maroon;
        color: @text;
    }

    button.control-center-clear-all:hover {
        background: @red;
        color: @base;
    }

    button.control-center-clear-all:active {
        background: shade(@maroon, 1.2);
        border: 1px solid shade(@red, 1.2);
    }

    /* ===========================================
        Do Not Disturb
        =========================================== */

    .widget-dnd {
        border-bottom: 1px solid @mantle;
    }

    .widget-dnd * {
        font-size: 0.875rem;
        color: @subtext1;
    }

    /* ===========================================
        Notification Box
        =========================================== */

    .notification-group > .vertical {
        border: 1px solid transparent;
        border-radius: 0.5rem;
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .notification-group:not(.collapsed) > .vertical {
        border: 1px solid @surface2;
        background: alpha(@crust, 0.5);
        padding: 0.5rem;
        padding-bottom: 0;
    }

    .notification-group > .vertical .horizontal {
        padding-bottom: 0.3rem;
    }

    .notification-group .notification-background {
        margin-bottom: 0.5rem;
    }

    .notification-group .image-button {
        padding-top: 0.4rem;
    }

    .notification-background {
        background: @crust;
        border: 1px solid @mantle;
        border-radius: 0.5rem;
        padding: 0.5rem;
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .notification-row:hover {
        background: @surface1;
    }

    .notification-background button {
        padding: 0.25rem;
    }

    .notification-background .summary {
        font-size: 1.1rem;
        font-weight: 700;
        color: @rosewater;
    }

    .notification-background .time {
        color: @subtext1;
        font-size: 0.875rem;
    }

    .notification-background .image {
        border-radius: 0.5rem;
        border: 1px solid alpha(@mantle, 0.8);
        margin-right: 0.5rem;
    }

    .notification-background .body {
        font-size: 0.875rem;
        color: @subtext1;
    }

    .notification-group scrolledwindow {
        min-height: 3em;
    }

    .background.floating-notifications scrolledwindow viewport {
        margin: 0.5rem;
    }

    .background.floating-notifications
        scrolledwindow
        viewport
        .notification-background {
        background: alpha(@crust, 0.875);
        border: 1px solid @mantle;
        border-radius: 0.5rem;
        padding: 0.5rem;
        margin-bottom: 0.5rem;
        transition: 0.2s cubic-bezier(0.4, 0, 0.2, 1);
    }

    .background.floating-notifications
        scrolledwindow
        viewport
        .notification-background
        scrolledwindow {
        min-height: 3em;
    }

    /* ===========================================
        mpris
        =========================================== */

    .widget-mpris-player {
        all: unset;
        padding: 0.5rem;
        border: 1px solid @mantle;
        border-radius: 0.5rem;
        background: alpha(@base, 0.75);
    }

    .widget-mpris-title {
        font-size: 1.1rem;
        font-weight: 700;
        color: @blue;
    }
    .widget-mpris-subtitle {
        all: unset;
        font-size: 0.875rem;
        color: @subtext1;
    }
    .widget-mpris-album-art {
        all: unset;
        border-radius: 0.5rem;
        border: 1px solid @mantle;
        margin-right: 0.5rem;
    }

    .widget-buttons-grid {
        margin-bottom: 1rem;
    }

    .widget-buttons-grid button {
        padding: 2rem 1rem;
        border-radius: 0.5rem;
        border: 1px solid @mantle;
    }

    .linked .notification-action {
        color: @yellow;
        outline-offset: -3px;
        padding: 0.5rem;
    }
  ";

in
{
  services.swaync = {
    enable = true;
    package = pkgs.callPackage ./../../../../pkgs/derivations/swaync.nix { };

    settings = {
      widgets = [
        "inhibitors"
        "title"
        "dnd"
        "notifications"
        "mpris"
      ];
      cssPriority = "user";
      layer = "overlay";
      layer-shell = true;
      widget-config = {
        mpris = {
          image-size = 96;
          image-radius = 12;
          blur = true;
        };
      };
    };

    style = ''
      ${styleVariableString}
      ${styleMainString}
    '';
  };
}
