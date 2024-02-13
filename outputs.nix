{ self, nixpkgs-stable, nixpkgs-unstable, nixos-hardware, home-manager, nur, musnix }:
let
  user = "ubunteous";
  system = "x86_64-linux";
  
  # # install unstable packages if issue with stable
  # overlay-unstable = final: prev: {
  #   # use this variant if unfree packages are needed:
  #   unstable = import nixpkgs-unstable {
  #     inherit system;
  #     config.allowUnfree = true;
  #     unstable = nixpkgs-unstable.legacyPackages.${prev.system};
  #   };
  # };
  
  # install stable packages if issue with unstable
  overlay-stable = final: prev: {
    # use this variant if unfree packages are needed:
    stable = import nixpkgs-stable {
      inherit system;
      config.allowUnfree = true;
      stable = nixpkgs-stable.legacyPackages.${prev.system};
    };
  };
in
{
  nixosConfigurations = {
    #############
    #   NIXOS   #
    #############

    nixos = nixpkgs-unstable.lib.nixosSystem {
      system = system;
      specialArgs = { inherit user; };
      
      modules = [
        # Fix touchpad/wifi
        #<nixos-hardware/lenovo/thinkpad/t14s/amd/gen1>
        ./hardware/hardware-configuration.nix

        ./hosts/main-host.nix

        nur.nixosModules.nur
        musnix.nixosModules.musnix
        home-manager.nixosModules.home-manager

        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })

        #################
        #   NIX INDEX   #
        #################
        
        # nix-index-database.nixosModules.nix-index
        # # optional to also wrap and install comma
        # { programs.command-not-found.enable = false; }
        # # { programs.nix-index-database.comma.enable = true; }

        
        # ({ config, ... }: {
        #   environment.systemPackages = [ config.nur.repos.mic92.hello-nur ];
        # })

      ];
    };

    ###############
    #   MINIMAL   #
    ###############
    
    minimal = nixpkgs-unstable.lib.nixosSystem {
      system = system;
      specialArgs = { inherit user; };
      
      modules = [
        ./hosts/minimal.nix
        ./hardware/hardware-configuration.nix
        home-manager.nixosModules.home-manager

        # ./hosts/audition.nix
      ];
    };
  };
  
  ######################
  # HOME CONFIGURATION #
  ######################

  defaultPackage.${system} = home-manager.defaultPackage.${system};

  homeConfigurations = {
    # nix run . -- build --flake . # or switch
    # Then restart your shell or run exec $SHELL -l

    
    work = home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit user; };
      pkgs = import nixpkgs-unstable { system = system; };

      modules = [
        ./hosts/work.nix

        nur.nixosModules.nur
        # nur.hmModules.nur
      ];
    };
  };

}
