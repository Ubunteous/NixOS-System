{ self, nixpkgs-stable, nixpkgs-unstable, nixos-hardware, home-manager, nur
, musnix }:

let
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
in {
  nixosConfigurations = {
    #############
    #   NIXOS   #
    #############

    nixos = let user = "ubunteous";
    in nixpkgs-unstable.lib.nixosSystem {
      system = system;
      specialArgs = { inherit user; };

      modules = [
        # Fix touchpad/wifi
        #<nixos-hardware/lenovo/thinkpad/t14s/amd/gen1>
        ./hardware/laptop
        ./hosts/main.nix

        nur.modules.nixos.default
        musnix.nixosModules.musnix
        # stylix.nixosModules.stylix
        # agenix.nixosModules.default
        home-manager.nixosModules.home-manager
        # nix-index-database.nixosModules.nix-index

        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })

        #################
        #   NIX INDEX   #
        #################

        # nix-index-database.nixosModules.nix-index
        # # optional to also wrap and install comma
        # { programs.command-not-found.enable = false; }
        # # { programs.nix-index-database.comma.enable = true; }

        ###############
        #   PROXMOX   #
        ###############

        # proxmox-nixos.nixosModules.proxmox-ve

        # ({ pkgs, lib, ... }: {
        #   services.proxmox-ve.enable = true;
        #   nixpkgs.overlays = [ proxmox-nixos.overlays.${system} ];
        # })

      ];
    };

    ##############
    #   SERVER   #
    ##############

    server = let user = "nix";
    in nixpkgs-unstable.lib.nixosSystem {
      system = system;
      specialArgs = { inherit user; };
      modules = [
        ./hosts/server.nix
        ./hardware/server

        nur.modules.nixos.default
        musnix.nixosModules.musnix
        home-manager.nixosModules.home-manager

        ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
      ];
    };

    ###############
    #   MINIMAL   #
    ###############

    minimal = let user = "ubunteous";
    in nixpkgs-unstable.lib.nixosSystem {
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

  homeConfigurations = let user = "ubunteous";
  in {
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
