{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.zsh;
  users.users.iris = {
    isNormalUser = true;
    description = "iris";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager.users.iris =
    { pkgs, ... }:
    {
      home.stateVersion = "23.05";
      nixpkgs.config.allowUnfree = true;

      imports = [ ./home ];

      home.pointerCursor = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
        size = 24;
        x11 = {
          enable = true;
          defaultCursor = "Adwaita";
        };
      };
    };
}
