# full of stuff not usefull anymore

{
  description = "A flake for building my NixOS configuration";

  # To avoid rebuilding inputs on nixos-rebuild test/switch, use
  # sudo nixos-rebuild build --flake '.nix.d/#' beforehand
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    musnix.url = "github:musnix/musnix";
    nur.url = "github:nix-community/NUR";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    
    home-manager = {
      # url = "github:nix-community/home-manager";
      # inputs.nixpkgs.follows = "nixpkgs-unstable";
      
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";

    };

    # divide flakes in modules
    # flake-parts.url = "github:hercules-ci/flake-parts";
    
    # nix-ld = {
    # # nix-ld is now available as a nix module (v23)
    #   url = "github:Mic92/nix-ld";
    #   # inputs.nixpkgs.follows = "nixpkgs"; # "nixpkgs-unstable";
    # };

    # kmonad = {
    #   url = "github:kmonad/kmonad?dir=nix";
    #   # inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
    
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   # build with your own instance of nixpkgs
    #   inputs.nixpkgs.follows = "nixpkgs-unstable";
    # };
  };
  
  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, home-manager, nur, musnix }:
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

      #   # install stable packages if issue with unstable
      #   overlay-stable = final: prev: {
      #     # use this variant if unfree packages are needed:
      #     stable = import nixpkgs {
      #       inherit system;
      #       config.allowUnfree = true;
      #       stable = nixpkgs.legacyPackages.${prev.system};
      #     };
      #   };
      in
        {
          nixosConfigurations = {
            # nixos = nixpkgs.lib.nixosSystem {
            nixos = nixpkgs-unstable.lib.nixosSystem {
              # system = "x86_64-linux";
              system = system;
              specialArgs = { inherit user; };
              
              modules =
                [
                  ############
                  #   HOST   #
                  ############

                  ./hosts/main-host.nix              
                  # ./hosts/simple.nix
                  # ./hosts/wayland.nix # not operation yet
                  # ./hosts/minimal.nix

                  # Fix touchpad issues and maybe also wifi
                  ./hardware/hardware-configuration.nix

                  ##########
                  #   LD   #
                  ##########

                  # Note: nix-ld is essential to fix u-he plugins UI
                  
                  # ld will be fully available in NixOS 23.05
                  # nix-ld.nixosModules.nix-ld

                  # The module in this repository defines a new module under (programs.nix-ld.dev) instead of (programs.nix-ld) 
                  # to not collide with the nixpkgs version.
                  # { programs.nix-ld.dev.enable = true; }
                  
                  ################
                  #   UNSTABLE   #
                  ################

                  # ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-unstable ]; })

                  ##############
                  #   STABLE   #
                  ##############

                  # ({ config, pkgs, ... }: { nixpkgs.overlays = [ overlay-stable ]; })
                  
                  ##############
                  #   LENOVO   #
                  ##############

                  # rtw89-firmware has been removed because linux-firmware now contains it
                  # supposed to fix two bugs: unresponsive touchpad and wifi unavailable
                  # nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
                  
                  ##############
                  #   MUSNIX   #
                  ##############

                  musnix.nixosModules.musnix
                  
                  ###########
                  #   NUR   #
                  ###########

                  # use config.nur.repos... to install a package
                  nur.nixosModules.nur

                  ##############
                  #   KMONAD   #
                  ##############

                  # kmonad.nixosModules.default

                  ####################
                  #   HOME MANAGER   #
                  ####################
                  
                  home-manager.nixosModules.home-manager # make home manager available to configuration.nix
                  {
                    # use system-level nixpkgs => saves nixpkgs evaluation, adds consistency, removes NIX_PATH dependency
                    home-manager.useGlobalPkgs = true;
                  }

                  ################
                  #   HYPRLAND   #
                  ################

                  # hyprland.nixosModules.default
                  # { programs.hyprland.enable = true; }
                ];
            };

            ###############
            #   MINIMAL   #
            ###############
            
            minimal = nixpkgs-unstable.lib.nixosSystem {
              # system = "x86_64-linux";
              system = system;
              specialArgs = { inherit user; };
              
              modules =
                [
                  ./hosts/minimal.nix

                  # Fix touchpad issues and maybe also wifi
                  ./hardware/hardware-configuration.nix
                  # nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
                ];              
            };
          };

          ################
          #   HYPRLAND   #
          ################

          # hyprland with home manager
          # homeConfigurations.${user} = home-manager.lib.homeManagerConfiguration {
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
