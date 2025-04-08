{ home-manager, inputs, ... }:

{
  imports = [
    ./packages
    ./system
    ./users
    ./hardware-configuration.nix

    home-manager.nixosModules.home-manager
  ];

  home-manager.extraSpecialArgs = { inherit inputs; };

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

  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
