{ pkgs, ... }:
{

  xdg = {
    portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
      config.common.default = "*";
    };
  };

  security.rtkit.enable = true;
  security.polkit.enable = true;

  services = {
    flatpak.enable = true;
    gnome.gnome-keyring.enable = true;
    mpd.enable = true;
    printing.enable = true;
    displayManager.ly.enable = true;

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
    };

    xserver.enable = true;
    xserver.displayManager.gdm.enable = false;
    xserver.displayManager.gdm.wayland = true;
    xserver.desktopManager.gnome.enable = true;

    xserver.displayManager.session = [
      {
        manage = "desktop";
        name = "niri";
        start = "${pkgs.niri}/bin/niri";
      }
      {
        manage = "desktop";
        name = "sway";
        start = "${pkgs.swayfx}/bin/swayfx";
      }
    ];

    xserver.xkb = {
      layout = "gb";
      variant = "";
    };
  };

}
