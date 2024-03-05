{
  description = "A flake for building my NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    # nur.url = "github:nix-community/NUR";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # { inputs.nixpkgs.follows = "nixpkgs"; };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Pin flakes to a specific revision
    bitwig.url = "github:NixOS/nixpkgs?rev=2e5da39c7c24e1e132fa3e91850ecbd85d64c0a4";
    # bitwig.flake = false;

    # nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # hyprland = {
    #   url = "github:vaxerski/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager, bitwig }:
    let
      user = "ubunteous";
    in
      {
        nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          #inherit (nixpkgs) lib;
          specialArgs = { inherit user; };

          modules =
            let
              system = "x86_64-linux";
              defaults = { pkgs, ... }: {
                _module.args.bitwig = import inputs.bitwig {
                  # inherit (nixpkgs.stdenv.targetPlatform) system;
                  inherit system;
                  config.allowUnfree = true;
                };
              };
            in
              [
                
                defaults
                # use this in pkgs = []; to install bitwig
                # bitwig.bitwig-studio # version 3.3.x

                # kmonad.nixosModules.default

                ./hosts/configuration.nix
                ./hardware/hardware-configuration.nix
                inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1
                # nixos-hardware.nixosModules.lenovo-thinkpad-t14s-amd-gen1

                inputs.home-manager.nixosModules.home-manager # make home manager available to configuration.nix
                {
                  # use system-level nixpkgs => saves nixpkgs evaluation, adds consistency, removes NIX_PATH dependency
                  home-manager.useGlobalPkgs = true;
                }
              ];
        };
      };
}
