{
  description = "A flake for building my NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    # musnix.url = "github:musnix/musnix";
    # nur.url = "github:nix-community/NUR";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    unstable.url = "nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      # build with your own instance of nixpkgs
      inputs.nixpkgs.follows = "unstable";
    };
  };
  
  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, unstable, hyprland }:
    let
      user = "ubunteous";
    in
      {
        nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          
          specialArgs = { inherit user; };

          modules =
            [
              ############
              #   HOST   #
              ############
              
              ./hosts/main-host.nix
              # ./hosts/wayland.nix # not operation yet
              # ./hosts/minimal.nix
              ./hardware/hardware-configuration.nix
              inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
              # nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1

              ##############
              #   CONFIG   #
              ##############
              
              inputs.home-manager.nixosModules.home-manager # make home manager available to configuration.nix
              {
                # use system-level nixpkgs => saves nixpkgs evaluation, adds consistency, removes NIX_PATH dependency
                home-manager.useGlobalPkgs = true;
              }


              ################
              #   HYPRLAND   #
              ################

              inputs.hyprland.nixosModules.default
              { programs.hyprland.enable = true; }
            ];
        };

        
        # hyprland with home manager
        # homeConfigurations.${user} = inputs.home-manager.lib.homeManagerConfiguration {
        #   pkgs = nixpkgs.legacyPackages.x86_64-linux;
        #   modules = [
        #     hyprland.homeManagerModules.default
        #     {
        #       wayland.windowManager.hyprland = {
        #         enable = true;
        #         # xwayland.enable = false;
        #       };
        #     }
        #   ];
        # };

        
      };
}
