{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.displayManager.session = [
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

  services.xserver.xkb = {
    layout = "gb";
    variant = "";
  };
}
