{
  description = "A flake for building my NixOS configuration";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.05";
    # nur.url = "github:nix-community/NUR";

    # musnix.url = "github:musnix/musnix";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # { inputs.nixpkgs.follows = "nixpkgs"; };

    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    # hyprland = {
    #   url = "github:vaxerski/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  
  outputs = inputs @ { self, nixpkgs, nixos-hardware, home-manager  }:
    let
      user = "ubunteous";
    in
      {
        nixosConfigurations.nixos = inputs.nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          
          specialArgs = { inherit user; };

          modules =
            [
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
