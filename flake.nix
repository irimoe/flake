{
  description = "iris' nixos configs.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      spicetify-nix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };

          modules = [
            # system configuration
            { nixpkgs.config.allowUnfree = true; }

            # host-specific config
            ./hosts/nixos

            # Common modules
            ./modules/system

            # home manager and other modules
            home-manager.nixosModules.home-manager
            spicetify-nix.nixosModules.spicetify

            {
              users = {
                defaultUserShell = nixpkgs.legacyPackages.${system}.fish;
                users.iris = {
                  isNormalUser = true;
                  description = "iris";
                  extraGroups = [
                    "networkmanager"
                    "wheel"
                  ];
                };
              };

              # home manager configuration
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.iris = import ./modules/users/iris;
              };
            }
          ];
        };
      };

      packages.${system} = import ./pkgs/derivations {
        pkgs = nixpkgs.legacyPackages.${system};
      };

      homeConfigurations = {
        "iris@nixos" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          extraSpecialArgs = { inherit inputs; };
          modules = [
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./modules/users/iris
          ];
        };
      };
    };
}
