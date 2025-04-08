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

  outputs = { self, nixpkgs, home-manager, spicetify-nix, ... }@inputs:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        # Desktop configuration
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          
          modules = [
            # System configuration
            { nixpkgs.config.allowUnfree = true; }

            # Host-specific config
            ./hosts/nixos
            
            # Common modules
            ./modules/system
            
            # Home manager and other modules
            home-manager.nixosModules.home-manager
            spicetify-nix.nixosModules.spicetify
            
            # User configuration
            {
              # System-level user configuration
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

              # Home manager configuration
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.iris = import ./modules/users/iris;
              };
            }
          ];
        };

        # Server configuration
        server = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          
          modules = [
            # System configuration
            { nixpkgs.config.allowUnfree = false; }

            # Host-specific config
            ./hosts/server
            
            # Common modules
            ./modules/system
            ./modules/system/profiles/server.nix
            
            # User configuration
            {
              users.users.iris = {
                isNormalUser = true;
                description = "iris";
                extraGroups = [ "wheel" ];
                openssh.authorizedKeys.keys = [
                  # Add your SSH public key here
                  # "ssh-ed25519 AAAAC3...."
                ];
              };
            }
          ];
          
          modules = [
            # System configuration
            {
              nixpkgs.config.allowUnfree = true;
              # nixpkgs.overlays = [ (import ./overlays { inherit pkgs; }).default ];
            }

            # Host-specific config
            ./hosts/nixos
            
            # Common modules
            ./modules/system
            
            # Home manager and other modules
            home-manager.nixosModules.home-manager
            spicetify-nix.nixosModules.spicetify
            
            # User configuration
            {
              # System-level user configuration
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

              # Home manager configuration
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
      
      # Add package outputs for custom packages
      packages.${system} = import ./pkgs/derivations { 
        pkgs = nixpkgs.legacyPackages.${system};
      };
      
      # Optional: add home-manager standalone configurations
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