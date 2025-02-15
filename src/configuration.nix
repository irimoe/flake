{ home-manager, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./networking.nix
    ./l10n.nix
    ./services
    ./programs
    ./packages
    ./users
    ./home-manager.nix

    home-manager.nixosModules.home-manager
  ];

  nix = {
    settings = {
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  boot.loader = {
    systemd-boot.configurationLimit = 5;
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
