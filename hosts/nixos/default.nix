{ ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "nixos";

  boot.loader = {
    systemd-boot.configurationLimit = 5;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  system.stateVersion = "24.11";
}
